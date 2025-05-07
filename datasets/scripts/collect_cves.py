#!/usr/bin/env python3

import os
import json
import time
import asyncio
import logging
from datetime import datetime, timezone, timedelta
from typing import Dict, List, Set, Optional, Any
import aiohttp
import requests
from tqdm import tqdm
from dateutil import parser
from bs4 import BeautifulSoup
from github import Github
from git import Repo
from patch_analyzer import PatchAnalyzer
import re

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('cve_collection.log'),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)

# Constants
NVD_API_KEY = "59f7cca5-4e04-49ff-9fb6-02c8de722053"
NVD_BASE_URL = "https://services.nvd.nist.gov/rest/json/cves/2.0"
DATASET_DIR = "datasets/real-world"
CVE_DETAILS_FILE = os.path.join(DATASET_DIR, "cve_details.json")

# Memory-related CWEs we're interested in
MEMORY_CWES = {
    "CWE-416": "Use-After-Free",
    "CWE-787": "Out-of-Bound Write",
    "CWE-476": "NULL Pointer Deref",
    "CWE-119": "Buffer Overflow",
    "CWE-125": "Out-of-bounds Read",
    "CWE-415": "Double Free",
    "CWE-590": "Free of Memory not on Heap",
    "CWE-761": "Free of Pointer not at Start of Buffer",
    "CWE-763": "Release of Invalid Pointer",
    "CWE-824": "Access of Uninitialized Pointer",
    "CWE-825": "Expired Pointer Dereference"
}

# Project repositories to monitor (expandable)
PROJECTS = {
    # Operating Systems
    "linux": {
        "repo": "torvalds/linux",
        "type": "github"
    },
    "freebsd": {
        "repo": "freebsd/freebsd-src",
        "type": "github"
    },
    # Web Servers
    "nginx": {
        "repo": "nginx/nginx",
        "type": "github"
    },
    "apache": {
        "repo": "apache/httpd",
        "type": "github"
    },
    # Databases
    "mysql": {
        "repo": "mysql/mysql-server",
        "type": "github"
    },
    "postgresql": {
        "repo": "postgres/postgres",
        "type": "github"
    },
    "sqlite": {
        "repo": "sqlite/sqlite",
        "type": "github"
    },
    # Programming Languages
    "python": {
        "repo": "python/cpython",
        "type": "github"
    },
    "php": {
        "repo": "php/php-src",
        "type": "github"
    },
    "ruby": {
        "repo": "ruby/ruby",
        "type": "github"
    },
    # Network Libraries
    "openssl": {
        "repo": "openssl/openssl",
        "type": "github"
    },
    "curl": {
        "repo": "curl/curl",
        "type": "github"
    },
    "pjsip": {
        "repo": "pjsip/pjproject",
        "type": "github"
    },
    # Media Libraries
    "ffmpeg": {
        "repo": "FFmpeg/FFmpeg",
        "type": "github"
    },
    "gpac": {
        "repo": "gpac/gpac",
        "type": "github"
    },
    "libtiff": {
        "repo": "vadz/libtiff",
        "type": "github"
    },
    # System Libraries
    "glibc": {
        "repo": "bminor/glibc",
        "type": "github"
    },
    # Browser Engines
    "chromium": {
        "repo": "chromium/chromium",
        "type": "git",
        "url": "https://chromium.googlesource.com/chromium/src.git"
    },
    "firefox": {
        "repo": "mozilla/gecko-dev",
        "type": "github"
    },
    # Version Control
    "git": {
        "repo": "git/git",
        "type": "github"
    },
    # Container Technologies
    "docker": {
        "repo": "moby/moby",
        "type": "github"
    },
    "containerd": {
        "repo": "containerd/containerd",
        "type": "github"
    }
}

class CVECollector:
    def __init__(self, github_token: Optional[str] = None):
        self.session = requests.Session()
        self.session.headers.update({
            "apiKey": NVD_API_KEY,
            "User-Agent": "SecLLMHolmes-Collector/1.0",
            "Accept": "application/json"
        })
        self.existing_cves = self._load_existing_cves()
        self.github_token = os.getenv('GITHUB_TOKEN', '')
        self.patch_analyzer = PatchAnalyzer(github_token)
        
    def _load_existing_cves(self) -> Dict:
        """Load existing CVE details from file."""
        try:
            if os.path.exists(CVE_DETAILS_FILE):
                with open(CVE_DETAILS_FILE, 'r') as f:
                    return json.load(f)
            return {}
        except Exception as e:
            logging.error(f"Error loading existing CVEs: {e}")
            return {}

    def _save_cve_details(self, cve_details: Dict):
        """Save updated CVE details to file."""
        try:
            os.makedirs(os.path.dirname(CVE_DETAILS_FILE), exist_ok=True)
            with open(CVE_DETAILS_FILE, 'w') as f:
                json.dump(cve_details, f, indent=4)
        except Exception as e:
            logging.error(f"Error saving CVE details: {e}")

    def fetch_cves(self, start_date: datetime, end_date: datetime) -> List[Dict[str, Any]]:
        """
        修改后：遍历 MEMORY_CWES 中所有的 CWE ID，分多次请求 NVD，收集这些类型的漏洞。
        """
        potential_cves = []
        try:
            logger.info("Fetching CVEs for all memory-related CWE types.")
            for cwe_id in MEMORY_CWES.keys():
                params = {
                    "pubStartDate": start_date.strftime("%Y-%m-%dT%H:%M:%S.000Z"),
                    "pubEndDate": end_date.strftime("%Y-%m-%dT%H:%M:%S.000Z"),
                    "cweId": cwe_id,
                    "resultsPerPage": "50"
                }
                
                logger.info(f"Fetching CVEs for CWE-{cwe_id}")
                logger.debug(f"Request URL: {NVD_BASE_URL}")
                logger.debug(f"Request params: {params}")
                logger.debug(f"Request headers: {self.session.headers}")
                
                response = requests.get(
                    NVD_BASE_URL,
                    headers=self.session.headers,
                    params=params,
                    timeout=30
                )
                
                if response.status_code == 403:
                    logger.error("API key authentication failed. Please check your NVD API key.")
                    continue
                
                response.raise_for_status()
                
                data = response.json()
                logger.debug(f"Response data: {json.dumps(data, indent=2)}")
                
                if "vulnerabilities" in data:
                    for vuln in data["vulnerabilities"]:
                        cve_data = vuln.get("cve", {})
                        if self._is_relevant_cve(cve_data):
                            potential_cves.append(cve_data)
                
                total_results = data.get("totalResults", 0)
                logger.info(f"Total CWE-{cwe_id} results from NVD: {total_results}")
                logger.info(f"Found {len(potential_cves)} relevant CVEs")
                time.sleep(6)  # 遵守NVD推荐的查询节流
                
            logger.info(f"Collected total {len(potential_cves)} CVEs from NVD across all memory CWEs.")
        except requests.exceptions.RequestException as e:
            logger.error(f"Error fetching CVEs: {str(e)}")
            if hasattr(e, 'response') and e.response is not None:
                logger.error(f"Response text: {e.response.text}")
                logger.error(f"Response status code: {e.response.status_code}")
                logger.error(f"Response headers: {e.response.headers}")
        except Exception as e:
            logger.error(f"Unexpected error: {str(e)}")
        
        return potential_cves

    def _is_relevant_cve(self, cve_data: Dict[str, Any]) -> bool:
        """
        Check if a CVE is relevant based on our criteria
        """
        # Check if CVE affects any of our monitored projects
        if "configurations" not in cve_data:
            return False
            
        for config in cve_data["configurations"]:
            for node in config.get("nodes", []):
                for cpe_match in node.get("cpeMatch", []):
                    cpe = cpe_match.get("criteria", "").lower()
                    for project_name, project_info in PROJECTS.items():
                        if project_name.lower() in cpe:
                            return True
        print(project_name,cpe)
        return False

    def process_cve(self, cve_data: Dict[str, Any]):
        """仅保留来自 GitHub 的补丁链接"""
        try:
            cve_id = cve_data.get('id', '')
            
            # Extract CVE description
            cve_description = ""
            for desc in cve_data.get('descriptions', []):
                if desc.get('lang') == 'en':
                    cve_description = desc.get('value', '')
                    break
            
            # Extract CWE information
            cwe = None
            cwe_name = None
            weaknesses = cve_data.get('weaknesses', [])
            for weakness in weaknesses:
                for description in weakness.get('description', []):
                    cwe_id = description.get('value', '')
                    if cwe_id in MEMORY_CWES:
                        cwe = cwe_id.lower()
                        cwe_name = MEMORY_CWES[cwe_id]
                        break
            
            if not cwe:
                raise ValueError(f"No relevant CWE found for {cve_id}")
            
            # 在这里仅获取GitHub来源的patch链接
            references = cve_data.get('references', [])
            patch_urls = []
            for ref in references:
                url = ref.get('url', '')
                # 只收集github.com链接
                if "github.com" in url.lower():
                    # 如果URL中出现commit或patch关键字，也可继续判断
                    if any(keyword in url.lower() for keyword in ['commit', 'patch']):
                        patch_urls.append(url)
                    elif 'Patch' in ref.get('tags', []):
                        patch_urls.append(url)
            
            if not patch_urls:
                return None
                raise ValueError(f"No GitHub patch URLs found for {cve_id}")
            
            # Determine project
            project_name = self._determine_project(cve_data)
            if not project_name:
                raise ValueError(f"Could not determine project for {cve_id}")
            
            # Analyze patches
            patch_infos = []
            for url in patch_urls:
                try:
                    patch_info = self.patch_analyzer.analyze_patch(url)
                    if patch_info:
                        patch_infos.append(patch_info)
                except Exception as e:
                    logger.error(f"Error analyzing patch from {url}: {str(e)}")
            
            if not patch_infos:
                raise ValueError(f"No valid patch information found for {cve_id}")
            
            # Download patch files
            vuln_paths = []
            patch_paths = []
            for i, patch_info in enumerate(patch_infos):
                vuln_path, patch_path = self.patch_analyzer.download_patch(
                    patch_urls[i], 
                    cve_id, 
                    project_name,
                    cve_description  # Pass the CVE description
                )
                if vuln_path and patch_path:
                    vuln_paths.append(vuln_path)
                    patch_paths.append(patch_path)
            
            if not vuln_paths or not patch_paths:
                raise ValueError(f"Failed to download patch files for {cve_id}")
            
            # Create CVE entry with correct date fields
            published_date = cve_data.get('published', '')
            last_modified_date = cve_data.get('lastModified', '')
            
            cve_entry = {
                "file_path": patch_infos[0]["file_path"],
                "cwe": cwe,
                "cwe_name": cwe_name,
                "loc_before": patch_infos[0]["loc_before"],
                "loc_after": patch_infos[0]["loc_after"],
                "found": published_date.split('T')[0] if published_date else '',
                "fixed": last_modified_date.split('T')[0] if last_modified_date else ''
            }
            
            # Log CVE details
            logger.info(f"Successfully processed CVE ID: {cve_id}")
            logger.info(f"CWE: {cwe} - {cwe_name}")
            logger.info(f"Project: {project_name}")
            logger.info(f"Patch URLs: {patch_urls}")
            logger.info(f"Vulnerability Paths: {vuln_paths}")
            logger.info(f"Patch Paths: {patch_paths}")
            logger.info("---")
            
            return project_name, cve_id, cve_entry
            
        except Exception as e:
            logger.error(f"Error processing CVE: {str(e)}")
            return None

    async def run(self):
        """Main execution function."""
        logging.info("Starting CVE collection...")
        
        # Collect CVEs from 2023-01-01 to 2023-05-01 (120-day range)
        start_date = datetime(2024, 9, 1, tzinfo=timezone.utc)
        end_date = datetime(2024, 12, 28, tzinfo=timezone.utc)
        
        logger.info(f"Starting CVE collection for all memory-related CWE types")
        logger.info(f"Time range: {start_date} to {end_date}")
        
        potential_cves = self.fetch_cves(start_date, end_date)
        logger.info(f"Found {len(potential_cves)} potential CVEs to process")
        
        with tqdm(potential_cves, desc="Processing CVEs") as pbar:
            for cve in pbar:
                result = await self.process_cve(cve)
                if result:
                    project_name, cve_id, cve_entry = result
                    # Update existing CVE details
                    if project_name not in self.existing_cves:
                        self.existing_cves[project_name] = {}
                    self.existing_cves[project_name][cve_id] = cve_entry
                    
                    # Save after each successful processing to prevent data loss
                    self._save_cve_details(self.existing_cves)
                # Sleep between processing to avoid overwhelming resources
                time.sleep(1)
        
        logging.info("CVE collection completed.")

    def _determine_project(self, cve_data: Dict[str, Any]) -> Optional[str]:
        """Determine which project a CVE belongs to."""
        description = cve_data.get('descriptions', [{}])[0].get('value', '').lower()
        references = [ref.get('url', '').lower() for ref in cve_data.get('references', [])]
        
        for project_name, project_info in PROJECTS.items():
            if project_name.lower() in description:
                return project_name
            for ref in references:
                if project_name.lower() in ref:
                    return project_name
                if project_info['type'] == 'github':
                    repo_path = project_info['repo'].lower()
                    if f"github.com/{repo_path}" in ref:
                        return project_name
        return None

def main():
    collector = CVECollector()
    
    # Collect CVEs from 2023-01-01 to 2023-05-01 (120-day range)
    start_date = datetime(2024, 1, 1, tzinfo=timezone.utc)
    end_date = datetime(2024, 4, 1, tzinfo=timezone.utc)
    
    logger.info(f"Starting CVE collection for all memory-related CWE types")
    logger.info(f"Time range: {start_date} to {end_date}")
    
    potential_cves = collector.fetch_cves(start_date, end_date)
    logger.info(f"Found {len(potential_cves)} potential CVEs to process")
    # print(potential_cves)
    with tqdm(potential_cves, desc="Processing CVEs") as pbar:
        for cve in pbar:
            collector.process_cve(cve)
            # logger.info(cve)
            # Sleep between processing to avoid overwhelming resources
            time.sleep(1)

if __name__ == "__main__":
    main() 
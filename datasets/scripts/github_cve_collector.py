#!/usr/bin/env python3

import os
import json
import time
import logging
import requests
from datetime import datetime, timezone
from typing import Dict, List, Set, Optional, Any
from tqdm import tqdm
from patch_analyzer import PatchAnalyzer

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('cve_collection_github.log'),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)

# The same memory-related CWEs from collect_cves.py
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

# Example set of projects to monitor (same as collect_cves.py)
PROJECTS = {
    "linux": {
        "repo": "torvalds/linux",
        "type": "github"
    },
    "freebsd": {
        "repo": "freebsd/freebsd-src",
        "type": "github"
    },
    "nginx": {
        "repo": "nginx/nginx",
        "type": "github"
    },
    "apache": {
        "repo": "apache/httpd",
        "type": "github"
    },
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
    "glibc": {
        "repo": "bminor/glibc",
        "type": "github"
    },
    "chromium": {
        "repo": "chromium/chromium",
        "type": "git",
        "url": "https://chromium.googlesource.com/chromium/src.git"
    },
    "firefox": {
        "repo": "mozilla/gecko-dev",
        "type": "github"
    },
    "git": {
        "repo": "git/git",
        "type": "github"
    },
    "docker": {
        "repo": "moby/moby",
        "type": "github"
    },
    "containerd": {
        "repo": "containerd/containerd",
        "type": "github"
    }
}

DATASET_DIR = "datasets/real-world"
CVE_DETAILS_FILE = os.path.join(DATASET_DIR, "cve_details.json")

class GitHubCVECollector:
    """
    Collects memory-related CVEs from GitHub's Security Advisories API.
    Maintains much of the logic from collect_cves.py, but uses GitHub GraphQL queries instead of NVD.
    """

    def __init__(self, github_token: Optional[str] = None):
        self.existing_cves = self._load_existing_cves()
        self.github_token = github_token or os.getenv('GITHUB_TOKEN', '')
        self.patch_analyzer = PatchAnalyzer(self.github_token)
        self.session = requests.Session()
        self.session.headers.update({
            "Authorization": f"Bearer {self.github_token}",
            "Accept": "application/vnd.github.v3+json"
        })

    def _load_existing_cves(self) -> Dict:
        """Load existing CVE details from file (same as collect_cves.py)."""
        try:
            if os.path.exists(CVE_DETAILS_FILE):
                with open(CVE_DETAILS_FILE, 'r') as f:
                    return json.load(f)
            return {}
        except Exception as e:
            logging.error(f"Error loading existing CVEs: {e}")
            return {}

    def _save_cve_details(self, cve_details: Dict):
        """Save updated CVE details to file (same as collect_cves.py)."""
        try:
            os.makedirs(os.path.dirname(CVE_DETAILS_FILE), exist_ok=True)
            with open(CVE_DETAILS_FILE, 'w') as f:
                json.dump(cve_details, f, indent=4)
        except Exception as e:
            logging.error(f"Error saving CVE details: {e}")

    def _determine_project(self, cve_data: Dict[str, Any]) -> Optional[str]:
        """Figure out which project a CVE belongs to (similar to collect_cves.py)."""
        description_lower = cve_data.get('description', '').lower()
        cve_references = cve_data.get('references', [])

        for project_name, project_info in PROJECTS.items():
            if project_name.lower() in description_lower:
                return project_name
            for ref in cve_references:
                url_lower = ref.get("url", "").lower()
                if project_name.lower() in url_lower:
                    return project_name
                if project_info['type'] == 'github':
                    repo_path = project_info['repo'].lower()
                    if f"github.com/{repo_path}" in url_lower:
                        return project_name
        return None

    def fetch_cves(
        self,
        start_date: datetime,
        end_date: datetime,
    ) -> List[Dict[str, Any]]:
        """
        Queries GitHub's GraphQL API for all security advisories in the given date range.
        Then inspects each advisory's 'cwes' field to check for any memory-related CWE IDs.
        """
        collected_cves = []
        logger.info("Fetching all GitHub Security Advisories in date range, then filtering by advisory.cwes field.")

        published_since = start_date.isoformat()
        updated_since = end_date.isoformat()

        has_next_page = True
        after_cursor = None

        while has_next_page:
            query = """
            query($publishedSince: DateTime, $updatedSince: DateTime, $after: String) {
              securityAdvisories(
                first: 100
                publishedSince: $publishedSince
                updatedSince: $updatedSince
                after: $after
              ) {
                pageInfo {
                  hasNextPage
                  endCursor
                }
                nodes {
                  ghsaId
                  publishedAt
                  updatedAt
                  summary
                  description
                  references {
                    url
                  }
                  identifiers {
                    type
                    value
                  }
                  cwes(first: 10) {
                    nodes {
                      cweId
                      name
                    }
                  }
                }
              }
            }
            """
            variables = {
                "publishedSince": published_since,
                "updatedSince": updated_since,
                "after": after_cursor
            }

            logger.info("Querying GitHub advisories (paged)...")
            try:
                resp = self.session.post(
                    "https://api.github.com/graphql",
                    json={"query": query, "variables": variables},
                    timeout=30
                )
                resp.raise_for_status()
                data = resp.json()

                advisories = data.get("data", {}).get("securityAdvisories", {})
                has_next_page = advisories.get("pageInfo", {}).get("hasNextPage", False)
                after_cursor = advisories.get("pageInfo", {}).get("endCursor")

                for adv in advisories.get("nodes", []):
                    # Attempt to locate a CVE among the identifiers
                    cve_val = None
                    for identifier in adv.get("identifiers", []):
                        if identifier.get("type") == "CVE":
                            cve_val = identifier.get("value")
                            break

                    if not cve_val:
                        # If no CVE is listed, skip
                        continue

                    # Examine the cwes field
                    adv_cwes = adv.get("cwes", {}).get("nodes", [])
                    found_cwe_id = None
                    for cwe_node in adv_cwes:
                        cwe_id_str = cwe_node.get("cweId", "")
                        if cwe_id_str in MEMORY_CWES:
                            found_cwe_id = cwe_id_str
                            print(found_cwe_id)
                            break

                    if not found_cwe_id:
                        # No memory-related CWE in the cwes field, skip
                        continue

                    # Build our cve_info dict
                    cve_info = {
                        "id": cve_val,
                        "published": adv.get("publishedAt", ""),
                        "lastModified": adv.get("updatedAt", ""),
                        "descriptions": [
                            {
                                "lang": "en",
                                "value": adv.get("description", "")
                            }
                        ],
                        "references": [
                            {"url": ref.get("url", "")}
                            for ref in adv.get("references", [])
                        ],
                        "cwe_id": found_cwe_id,
                        "summary": adv.get("summary", ""),
                        "description": adv.get("description", ""),
                    }
                    collected_cves.append(cve_info)

                time.sleep(2)  # small delay to avoid hitting rate limits

            except requests.exceptions.RequestException as e:
                logger.error(f"Error fetching advisories (paged) from GitHub: {str(e)}")
                break

        logger.info(f"Collected {len(collected_cves)} total CVEs referencing memory CWEs via the cwes field.")
        return collected_cves

    def _is_relevant_cve(self, cve_data: Dict[str, Any]) -> bool:
        """
        Use the same logic from collect_cves.py to decide if a CVE affects any monitored project.
        Instead of searching 'configurations', we examine references and description for project indicators.
        """
        # Scan for project reference
        project_name = self._determine_project(cve_data)
        return project_name is not None

    def process_cve(self, cve_data: Dict[str, Any]):
        """
        Processes a CVE record, extracting GitHub patch references, analyzing patches, 
        and returning a structured record similar to collect_cves.py.
        """
        try:
            cve_id = cve_data.get("id")
            cwe_id = cve_data.get("cwe_id")

            if not cve_id or not cwe_id:
                raise ValueError("Missing crucial data for CVE record.")

            cwe_name = MEMORY_CWES.get(cwe_id, "")
            references = cve_data.get("references", [])

            # Filter for GitHub-based references indicating commits or patch
            patch_urls = []
            for ref in references:
                url = ref.get("url", "").lower()
                if "github.com" in url:
                    if any(keyword in url for keyword in ["commit", "patch"]):
                        patch_urls.append(ref["url"])

            if not patch_urls:
                # No patch URLs from GitHub, skip
                return None

            # Determine project from references
            project_name = self._determine_project(cve_data)
            if not project_name:
                raise ValueError(f"Could not determine project for {cve_id}")

            # Use PatchAnalyzer (same logic as collect_cves.py)
            patch_infos = []
            for url in patch_urls:
                try:
                    patch_info = self.patch_analyzer.analyze_patch(url)
                    if patch_info:
                        patch_infos.append(patch_info)
                except Exception as e:
                    logger.error(f"Error analyzing patch from {url}: {str(e)}")

            if not patch_infos:
                raise ValueError(f"No valid patch info for {cve_id}")

            # Download patch files
            vuln_paths = []
            patch_paths = []
            for i, patch_info in enumerate(patch_infos):
                vuln_path, patch_path = self.patch_analyzer.download_patch(
                    patch_urls[i],
                    cve_id,
                    project_name,
                    cve_data.get("description", "")
                )
                if vuln_path and patch_path:
                    vuln_paths.append(vuln_path)
                    patch_paths.append(patch_path)

            if not vuln_paths or not patch_paths:
                raise ValueError(f"Failed to download patch files for {cve_id}")

            # Format the final entry
            published_date = cve_data.get("published", "")
            last_modified_date = cve_data.get("lastModified", "")

            cve_entry = {
                "file_path": patch_infos[0]["file_path"],
                "cwe": cwe_id.lower(),
                "cwe_name": cwe_name,
                "loc_before": patch_infos[0].get("loc_before", 0),
                "loc_after": patch_infos[0].get("loc_after", 0),
                "found": published_date.split("T")[0] if published_date else "",
                "fixed": last_modified_date.split("T")[0] if last_modified_date else ""
            }

            logger.info(f"Processed CVE: {cve_id}")
            logger.info(f"CWE: {cve_id} => {cwe_name}")
            logger.info(f"Project: {project_name}")
            logger.info(f"Patch URLs: {patch_urls}")
            logger.info(f"Vulnerability Paths: {vuln_paths}")
            logger.info(f"Patch Paths: {patch_paths}")
            logger.info("---")

            return project_name, cve_id, cve_entry
        except Exception as e:
            logger.error(f"Error processing CVE {cve_data.get('id', '')}: {str(e)}")
            return None

    def run(self, start_date: datetime, end_date: datetime):
        """
        Main execution similar to collect_cves.py, but using the fetch_cves() from GitHub's API.
        """
        logger.info("Starting GitHub-based CVE collection...")

        potential_cves = self.fetch_cves(start_date, end_date)
        logger.info(f"Found {len(potential_cves)} potential CVEs to process")

        with tqdm(potential_cves, desc="Processing CVEs") as pbar:
            for cve in pbar:
                if not self._is_relevant_cve(cve):
                    continue
                result = self.process_cve(cve)
                if result:
                    project_name, cve_id, cve_entry = result
                    # Update existing CVE details
                    if project_name not in self.existing_cves:
                        self.existing_cves[project_name] = {}
                    self.existing_cves[project_name][cve_id] = cve_entry
                    self._save_cve_details(self.existing_cves)
                time.sleep(1)

        logger.info("GitHub CVE collection completed.")

def main():
    collector = GitHubCVECollector()
    # Example time window (adjust as needed)
    start_date = datetime(2024, 1, 1, tzinfo=timezone.utc)
    end_date = datetime(2024, 4, 1, tzinfo=timezone.utc)

    collector.run(start_date, end_date)

if __name__ == "__main__":
    main() 
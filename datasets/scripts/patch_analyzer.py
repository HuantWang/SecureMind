#!/usr/bin/env python3

import os
import re
import logging
from typing import Dict, Tuple, Optional
import requests
from github import Github
from git import Repo
import tempfile

class PatchAnalyzer:
    def __init__(self, github_token: Optional[str] = None):
        if github_token:
            self.github = Github('')
        else:
            self.github = Github('')
            logging.warning("GitHub token not provided. GitHub patch analysis will not be available.")
        self.session = requests.Session()
    
    def analyze_patch(self, patch_url: str) -> Optional[Dict]:
        """
        Analyze a patch from various sources (GitHub, Patchwork, raw URL, etc.)
        Returns a dictionary containing patch analysis information
        """
        try:
            if "github.com" in patch_url:
                # Extract repo name and commit hash from GitHub URL
                match = re.search(r"github\.com/([^/]+/[^/]+)/commit/([a-f0-9]+)", patch_url)
                if match:
                    repo_name, commit_hash = match.groups()
                    return self.analyze_github_patch(repo_name, commit_hash)
            elif "patchwork.kernel.org" in patch_url:
                # Handle Patchwork URLs
                return self.analyze_raw_patch(patch_url)
            else:
                # For other URLs, treat as raw patch
                return self.analyze_raw_patch(patch_url)
            
        except Exception as e:
            logging.error(f"Error analyzing patch: {e}")
            return None
    
    def analyze_github_patch(self, repo_name: str, commit_hash: str) -> Dict:
        """Analyze a patch from a GitHub commit."""
        try:
            repo = self.github.get_repo(repo_name)
            commit = repo.get_commit(commit_hash)
            
            # Get the first file change (most CVEs affect primarily one file)
            file_changes = commit.files
            if not file_changes:
                return None
            
            main_file = file_changes[0]
            
            github_patch = {
                "file_path": main_file.filename,
                "loc_before": self._count_lines(main_file.patch, before=True),
                "loc_after": self._count_lines(main_file.patch, before=False)
            }
            # print(github_patch)
            # exit()
            return github_patch
        except Exception as e:
            logging.error(f"Error analyzing GitHub patch: {e}")
            return None
    
    def analyze_raw_patch(self, patch_url: str) -> Dict:
        """Analyze a raw patch file."""
        try:
            response = self.session.get(patch_url)
            response.raise_for_status()
            patch_content = response.text
            
            # Extract file path from patch
            file_path = self._extract_file_path(patch_content)
            
            return {
                "file_path": file_path,
                "loc_before": self._count_lines(patch_content, before=True),
                "loc_after": self._count_lines(patch_content, before=False)
            }
        except Exception as e:
            logging.error(f"Error analyzing raw patch: {e}")
            return None
    
    def download_patch(self, patch_url: str, cve_id: str, project: str, cve_description: str = "") -> Tuple[str, str]:
        """Download vulnerable and patched versions of the code."""
        try:
            # Create directory structure
            base_dir = os.path.join("datasets", "real-world", project, cve_id)
            os.makedirs(base_dir, exist_ok=True)
            
            vuln_path = os.path.join(base_dir, "vuln.c")
            patch_path = os.path.join(base_dir, "patch.c")
            desc_path = os.path.join(base_dir, "vuln.txt")
            
            # Save CVE description
            if cve_description:
                with open(desc_path, 'w') as f:
                    f.write(f"CVE ID: {cve_id}\n")
                    f.write(f"Description:\n{cve_description}\n")
                    f.write(f"\nPatch URL: {patch_url}")
            
            if "github.com" in patch_url:
                # Extract repo name and commit hash from GitHub URL
                match = re.search(r"github\.com/([^/]+/[^/]+)/commit/([a-f0-9]+)", patch_url)
                if match:
                    repo_name, commit_hash = match.groups()
                    repo = self.github.get_repo(repo_name)
                    commit = repo.get_commit(commit_hash)
                    
                    # Get the first file change
                    file_changes = commit.files
                    if file_changes:
                        main_file = file_changes[0]
                        
                        # Get the parent commit for vulnerable version
                        parent_commit = commit.parents[0]
                        
                        # Get file content from parent commit (vulnerable version)
                        vuln_content = repo.get_contents(main_file.filename, ref=parent_commit.sha).decoded_content.decode('utf-8')
                        
                        # Get file content from current commit (patched version)
                        patch_content = repo.get_contents(main_file.filename, ref=commit.sha).decoded_content.decode('utf-8')
                        
                        # Save both versions
                        with open(vuln_path, 'w') as f:
                            f.write(vuln_content)
                        with open(patch_path, 'w') as f:
                            f.write(patch_content)
                        
                        return vuln_path, patch_path
            else:
                # For non-GitHub URLs, use the existing patch parsing logic
                response = self.session.get(patch_url)
                response.raise_for_status()
                patch_content = response.text
                
                # Extract and save vulnerable and patched versions
                vuln_code, patched_code = self._extract_code_versions(patch_content)
                
                with open(vuln_path, 'w') as f:
                    f.write(vuln_code)
                with open(patch_path, 'w') as f:
                    f.write(patched_code)
                
                return vuln_path, patch_path
                
        except Exception as e:
            logging.error(f"Error downloading patch: {e}")
            return None, None
    
    def _count_lines(self, patch_content: str, before: bool = True) -> int:
        """Count lines in the patch (before or after the change)."""
        lines = 0
        for line in patch_content.split('\n'):
            if before and not line.startswith('+'):
                lines += 1
            elif not before and not line.startswith('-'):
                lines += 1
        return lines
    
    def _extract_file_path(self, patch_content: str) -> str:
        """Extract the affected file path from patch content."""
        path_match = re.search(r'(?:---|\+\+\+) [ab]/(.+)', patch_content)
        if path_match:
            return path_match.group(1)
        return ""
    
    def _extract_code_versions(self, patch_content: str) -> Tuple[str, str]:
        """Extract vulnerable and patched versions from patch content."""
        vuln_lines = []
        patch_lines = []
        
        # Split patch content into lines
        lines = patch_content.split('\n')
        
        # Find the actual patch content (after the headers)
        start_idx = 0
        in_patch = False
        current_file = None
        
        for i, line in enumerate(lines):
            # Skip HTML content if present
            if line.strip().startswith('<') and line.strip().endswith('>'):
                continue
                
            # Look for the start of a patch
            if line.startswith('diff --git') or line.startswith('Index:') or line.startswith('==='):
                in_patch = True
                current_file = None
                continue
                
            # Get the target file name
            if in_patch and (line.startswith('--- ') or line.startswith('+++ ')):
                file_path = line[4:].strip()
                if file_path.startswith('a/') or file_path.startswith('b/'):
                    file_path = file_path[2:]
                if file_path and not current_file:
                    current_file = file_path
                continue
            
            # Start collecting code after the @@ marker
            if line.startswith('@@'):
                start_idx = i + 1
                break
        
        # Process the actual patch content
        current_lines = []
        for line in lines[start_idx:]:
            # Skip empty lines and additional diff headers
            if not line or line.startswith('diff --git') or line.startswith('index '):
                continue
                
            # Skip @@ lines
            if line.startswith('@@'):
                continue
                
            # Process code lines
            if line.startswith('-'):
                if current_lines:
                    vuln_lines.extend(current_lines)
                    current_lines = []
                vuln_lines.append(line[1:])
            elif line.startswith('+'):
                if current_lines:
                    patch_lines.extend(current_lines)
                    current_lines = []
                patch_lines.append(line[1:])
            else:
                if line.startswith(' '):
                    line = line[1:]
                current_lines = [line]
                vuln_lines.extend(current_lines)
                patch_lines.extend(current_lines)
        
        # Join the lines and return both versions
        vuln_code = '\n'.join(line for line in vuln_lines if line)
        patch_code = '\n'.join(line for line in patch_lines if line)
        
        return vuln_code, patch_code
    
    def clone_repo(self, repo_url: str, commit_hash: str) -> str:
        """Clone a specific commit from a repository."""
        with tempfile.TemporaryDirectory() as temp_dir:
            try:
                repo = Repo.clone_from(repo_url, temp_dir)
                repo.git.checkout(commit_hash)
                return temp_dir
            except Exception as e:
                logging.error(f"Error cloning repository: {e}")
                return None 

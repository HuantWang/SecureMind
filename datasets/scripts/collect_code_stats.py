import os
import numpy as np
import matplotlib.pyplot as plt
from transformers import AutoTokenizer

def gather_code_stats(base_dirs):
    """
    Gathers line-count and token-count statistics for all .c files
    under the provided base directories.

    :param base_dirs: list of directory paths (e.g. ['data/SARD', 'data/Realworld'])
    :return: dictionary with:
             {
               "vuln_lines": [...],
               "nonvuln_lines": [...],
               "vuln_tokens": [...],
               "nonvuln_tokens": [...]
             }
    """
    # Initialize the CodeBERT tokenizer
    tokenizer = AutoTokenizer.from_pretrained("microsoft/codebert-base")

    stats = {
        "vuln_lines": [],
        "nonvuln_lines": [],
        "vuln_tokens": [],
        "nonvuln_tokens": []
    }

    for base_dir in base_dirs:
        if not os.path.exists(base_dir):
            continue

        # Walk through the directory collecting .c files
        for root, dirs, files in os.walk(base_dir):
            for f in files:
                if f.endswith(".c"):
                    file_path = os.path.join(root, f)

                    # Read entire file content to count lines/tokens
                    with open(file_path, "r", encoding="utf-8", errors="ignore") as fp:
                        content = fp.read()
                    
                    # Count non-empty lines
                    lines = content.splitlines()
                    line_count = sum(1 for line in lines if line.strip())

                    # Use CodeBERT tokenizer for token count
                    tokens = tokenizer.tokenize(content)
                    token_count = len(tokens)

                    # Determine vulnerability status based on filename
                    if f == "vuln.c":
                        stats["vuln_lines"].append(line_count)
                        stats["vuln_tokens"].append(token_count)
                    elif f == "patch.c":
                        stats["nonvuln_lines"].append(line_count)
                        stats["nonvuln_tokens"].append(token_count)
                    else:
                        # Skip files not named "vuln.c" or "patch.c"
                        continue

    return stats

def plot_cdf(dist_vuln, dist_nonvuln, output_file, title, x_label):
    """
    Plots the CDF of two distributions (vulnerable vs. non-vulnerable).

    :param dist_vuln: list of numeric values for the vulnerable files
    :param dist_nonvuln: list of numeric values for the non-vulnerable files
    :param output_file: file name for saving the plot
    :param title: title of the plot
    :param x_label: label for the x-axis
    """
    plt.figure(figsize=(8, 6))
    
    # Sort data
    v1 = np.sort(dist_vuln)
    v2 = np.sort(dist_nonvuln)

    # Compute the CDF values
    y1 = np.arange(len(v1)) / float(len(v1))
    y2 = np.arange(len(v2)) / float(len(v2))

    plt.plot(v1, y1, label="Vulnerable", color="red")
    plt.plot(v2, y2, label="Non-Vulnerable", color="blue")

    plt.title(title)
    plt.xlabel(x_label)
    plt.ylabel("CDF")
    plt.legend(loc="best")
    plt.tight_layout()
    plt.savefig(output_file)
    plt.close()

def main():
    # Adjust these directories as needed
    base_dirs = [
        "data/SARD",
        "data/Realworld"
        # You can add more directories here (e.g., GitHub source trees)
    ]

    stats = gather_code_stats(base_dirs)

    # Plot CDF for line counts
    if stats["vuln_lines"] or stats["nonvuln_lines"]:
        plot_cdf(
            stats["vuln_lines"],
            stats["nonvuln_lines"],
            "cdf_lines.png",
            "CDF for Lines of Code",
            "Number of Lines"
        )

    # Plot CDF for token counts
    if stats["vuln_tokens"] or stats["nonvuln_tokens"]:
        plot_cdf(
            stats["vuln_tokens"],
            stats["nonvuln_tokens"],
            "cdf_tokens.png",
            "CDF for Tokens",
            "Number of Tokens"
        )

    # Optionally, print out the distributions or other summaries
    print("Vulnerable files:", len(stats["vuln_lines"]))
    print("Non-vulnerable files:", len(stats["nonvuln_lines"]))

if __name__ == "__main__":
    main() 
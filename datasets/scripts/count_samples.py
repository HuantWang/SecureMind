import os
from collections import defaultdict
import matplotlib.pyplot as plt

def count_cwe_samples(base_path):
    cwe_counts = defaultdict(lambda: {'process4detect': 0, 'raw': 0})
    
    # Count process4detect samples
    process_path = os.path.join(base_path, 'process4detect')
    if os.path.exists(process_path):
        for cwe_dir in os.listdir(process_path):
            if cwe_dir.startswith('CWE-'):
                cwe_path = os.path.join(process_path, cwe_dir)
                if os.path.isdir(cwe_path):
                    sample_count = len(os.listdir(cwe_path))
                    cwe_counts[cwe_dir]['process4detect'] = sample_count

    # Count raw samples
    raw_path = os.path.join(base_path, 'raw')
    if os.path.exists(raw_path):
        for cwe_dir in os.listdir(raw_path):
            if cwe_dir.startswith('CWE-'):
                cwe_path = os.path.join(raw_path, cwe_dir)
                if os.path.isdir(cwe_path):
                    sample_count = len(os.listdir(cwe_path))
                    cwe_counts[cwe_dir]['raw'] = sample_count
                    
    return cwe_counts

def plot_pie_charts(sard_counts, realworld_counts):
    # Create figure with 2x2 subplots
    fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(15, 15))
    
    # SARD Process4detect
    sard_process = {k: v['process4detect'] for k,v in sard_counts.items()}
    ax1.pie(sard_process.values(), labels=sard_process.keys(), autopct='%1.1f%%')
    ax1.set_title('SARD Process4detect Distribution')

    # SARD Raw
    sard_raw = {k: v['raw'] for k,v in sard_counts.items()}
    ax2.pie(sard_raw.values(), labels=sard_raw.keys(), autopct='%1.1f%%')
    ax2.set_title('SARD Raw Distribution')

    # Realworld Process4detect
    realworld_process = {k: v['process4detect'] for k,v in realworld_counts.items()}
    ax3.pie(realworld_process.values(), labels=realworld_process.keys(), autopct='%1.1f%%')
    ax3.set_title('Realworld Process4detect Distribution')

    # Realworld Raw
    realworld_raw = {k: v['raw'] for k,v in realworld_counts.items()}
    ax4.pie(realworld_raw.values(), labels=realworld_raw.keys(), autopct='%1.1f%%')
    ax4.set_title('Realworld Raw Distribution')

    plt.tight_layout()
    plt.savefig('pie_charts.png')
    plt.close()

def plot_bar_charts(sard_counts, realworld_counts):
    # Create figure with 2 subplots
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(15, 10))
    
    # SARD Bar Chart
    cwes = list(sard_counts.keys())
    process_counts = [v['process4detect'] for v in sard_counts.values()]
    raw_counts = [v['raw'] for v in sard_counts.values()]
    
    x = range(len(cwes))
    width = 0.35
    
    ax1.bar([i - width/2 for i in x], process_counts, width, label='Process4detect')
    ax1.bar([i + width/2 for i in x], raw_counts, width, label='Raw')
    ax1.set_ylabel('Number of Samples')
    ax1.set_title('SARD Dataset Sample Distribution')
    ax1.set_xticks(x)
    ax1.set_xticklabels(cwes)
    ax1.legend()

    # Realworld Bar Chart
    cwes = list(realworld_counts.keys())
    process_counts = [v['process4detect'] for v in realworld_counts.values()]
    raw_counts = [v['raw'] for v in realworld_counts.values()]
    
    x = range(len(cwes))
    
    ax2.bar([i - width/2 for i in x], process_counts, width, label='Process4detect')
    ax2.bar([i + width/2 for i in x], raw_counts, width, label='Raw')
    ax2.set_ylabel('Number of Samples')
    ax2.set_title('Realworld Dataset Sample Distribution')
    ax2.set_xticks(x)
    ax2.set_xticklabels(cwes)
    ax2.legend()

    plt.tight_layout()
    plt.savefig('bar_charts.png')
    plt.close()

def print_dataset_stats(dataset_name, counts):
    print(f"\n{dataset_name} Dataset Statistics:")
    print("-" * 60)
    print(f"{'CWE':<15} {'Process4detect':<15} {'Raw':<15}")
    print("-" * 60)
    
    total_process = 0
    total_raw = 0
    
    for cwe in sorted(counts.keys()):
        process_count = counts[cwe]['process4detect']
        raw_count = counts[cwe]['raw']
        print(f"{cwe:<15} {process_count:<15} {raw_count:<15}")
        total_process += process_count
        total_raw += raw_count
    
    print("-" * 60)
    print(f"{'Total:':<15} {total_process:<15} {total_raw:<15}")

def main():
    data_dir = "data"
    
    # Count SARD samples
    sard_path = os.path.join(data_dir, "SARD")
    sard_counts = {}
    if os.path.exists(sard_path):
        sard_counts = count_cwe_samples(sard_path)
        print_dataset_stats("SARD", sard_counts)
    
    # Count Realworld samples
    realworld_path = os.path.join(data_dir, "Realworld")
    realworld_counts = {}
    if os.path.exists(realworld_path):
        realworld_counts = count_cwe_samples(realworld_path)
        print_dataset_stats("Realworld", realworld_counts)

    # Generate visualizations
    if sard_counts or realworld_counts:
        plot_pie_charts(sard_counts, realworld_counts)
        plot_bar_charts(sard_counts, realworld_counts)

if __name__ == "__main__":
    main() 
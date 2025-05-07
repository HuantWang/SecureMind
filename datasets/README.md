# Datasets

## Project Overview
This repository contains test cases and data for ISMM (International Symposium on Memory Management) related experiments and analysis.

## Directory Structure and Data Summary

```
ISMM/
├── datasets/
    ├── augmented        # Augmented test cases
    ├── compile         # Compilation-related files
    ├── few-shot        # Few-shot information
    ├── real-world      # Real-world vulnerability cases collected from open-source projects or industry
    ├── sard           # SARD 
    ├── scripts           # Scripts for data collection
```

### Data Categories Summary

# Vulnerability Dataset Overview

This dataset contains categorized samples of security vulnerabilities based on Common Weakness Enumeration (CWE). The table below provides details about the number of raw and augmented samples for each category.

## Dataset Details

| CWE      | Description                                                                 | #Raw Samples | #Aug. Samples |
|----------|-----------------------------------------------------------------------------|--------------|---------------|
| CWE-119  | Improper restriction of operations within the bounds of a memory buffer (a.k.a buffer overflow) | 120          | 1,800         |
| CWE-125  | Out-of-bounds read                                                          | 180          | 2,700         |
| CWE-190  | Integer overflow or wraparound (focusing on memory leaks under this category) | 24        | 360           |
| CWE-415  | Double free                                                                 | 198          | 2,970         |
| CWE-416  | Use after free                                                              | 270          | 4,050         |
| CWE-476  | NULL pointer dereference                                                   | 144          | 2,160         |
| CWE-787  | Out-of-bounds write                                                        | 78           | 1,170         |
| CWE-824  | Access of uninitialized pointer                                            | 64           | 960           |

## Notes
- **Raw Samples**: Original, unmodified test cases collected from datasets such as SARD and real-world sources.
- **Augmented Samples**: Artificially generated samples to improve model robustness via data augmentation techniques.

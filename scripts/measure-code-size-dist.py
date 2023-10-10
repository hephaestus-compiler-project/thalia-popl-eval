#! /usr/bin/env python3
#
# ./measure-code-size-dist.py --input <bug-dir> --output <csv-file> --suffix <sufix of source files>
import argparse
import csv
import glob
import os
from pathlib import Path


def get_args():
    parser = argparse.ArgumentParser(
        description='Compute distribution of code size')
    parser.add_argument("--input", help="Directory of generated programs")
    parser.add_argument("--output", help="File of output csv")
    parser.add_argument("--suffix", required=True,
                        type=str,
                        help='Suffix of generated files (e.g., .groovy)')
    return parser.parse_args()


def compute_code_size_dist(args):
    glob_pattern = f"{args.input}/*/generator/iter_*/*{args.suffix}"
    sizes = []
    for filepath in glob.glob(glob_pattern):
        file_size = os.path.getsize(filepath)
        file_size_mb = file_size / 1024
        with open(filepath, 'r') as f:
            line_count = sum(1 for _ in f)
        sizes.append((file_size_mb, line_count))
    return sizes


def main():
    args = get_args()
    sizes = compute_code_size_dist(args)
    os.makedirs(Path(args.output).parent.absolute(), exist_ok=True)
    with open(args.output, mode="w", newline="") as file:
        writer = csv.writer(file)
        writer.writerows(sizes)


if __name__ == "__main__":
    main()

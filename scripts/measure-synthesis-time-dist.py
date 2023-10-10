#! /usr/bin/env python3
#
# ./time-dist.py --input <bug-dir> --output <csv-file>
import argparse
import csv
import glob
import json
import linecache
import os
from pathlib import Path


def get_args():
    parser = argparse.ArgumentParser(
        description='Compute distribution of code size')
    parser.add_argument("--input", help="Directory of generated programs")
    parser.add_argument("--output", help="File of output csv")
    return parser.parse_args()


def process_stats(args):
    glob_pattern = f"{args.input}/*/stats.json"
    data = {}
    for file in glob.glob(glob_pattern):
        with open(file) as f:
            stats = json.load(f)

        programs = int(stats["totals"]["passed"]) + int(
            stats["totals"]["failed"])
        gen_time = float(stats["synthesis_time"])
        gen_time_per_program = gen_time / programs
        bugdir = file.rsplit(os.sep, 1)[0]
        logfile = os.path.join(bugdir, "logs", "api-generator")
        line = linecache.getline(logfile, 3)
        graph_size = int(line.split("Number of edges:")[1])
        lib = bugdir.rsplit(os.sep)[-1].rsplit("-", 1)[0]
        if lib not in data:
            data[lib] = {
                "size": graph_size,
                "gen_time": [gen_time_per_program]
            }
        else:
            data[lib]["gen_time"].append(gen_time_per_program)
    records = []
    for lib, stats in data.items():
        size = stats["size"]
        gen_time = sum(stats["gen_time"]) / len(stats["gen_time"])
        records.append((lib, size, gen_time))

    return records


def main():
    args = get_args()
    data = process_stats(args)
    os.makedirs(Path(args.output).parent.absolute(), exist_ok=True)
    with open(args.output, mode="w", newline="") as file:
        writer = csv.writer(file)
        writer.writerows(data)


if __name__ == "__main__":
    main()

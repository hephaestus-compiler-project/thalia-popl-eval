"""
Example run to produce figures:
    python analysis.py --language kotlin --whitelist whitelists/kotlin.txt
"""
import argparse
import os
import csv

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import matplotlib.patches as mpatches

from collections import defaultdict


sns.set(style="whitegrid")
plt.rcParams['font.monospace'] = 'Inconsolata Medium'
plt.rcParams['axes.labelsize'] = 23
plt.rcParams['axes.titlesize'] = 23
plt.rcParams['xtick.labelsize'] = 20
plt.rcParams['ytick.labelsize'] = 20
plt.rcParams['legend.fontsize'] = 18
plt.rcParams['figure.titlesize'] = 24
plt.rcParams['figure.figsize'] = (8, 4)

HEPH_PATH = os.path.join("hephaestus", "results")
THALIA_PATH = os.path.join("thalia", "results")
COMB_PATH = os.path.join("combination", "results")
HEPH_SORTED_MODES = [
    "base",
    "erase",
    "inject",
    "all"
]
THALIA_SORTED_MODES = [
    "base",
    "erase",
    "inject",
    "both",
    "all"
]
SORTED_MODES = [
    "base",
    "base-erase",
    "base-inject",
    "base-both",
    "all"
]
METRICS = ["line", "branch", "function"]


def get_args():
    # Create the argument parser
    parser = argparse.ArgumentParser(description='Language Printer')
    parser.add_argument(
        '--language',
        required=True,
        choices=['kotlin', 'groovy', 'scala'],
        help='Specify the language'
    )
    parser.add_argument(
        "--coverage-data",
        required=True,
        type=str,
        help="Directory that contains coverage analysis data"
    )
    parser.add_argument(
        "--output-dir",
        required=True,
        type=str,
        help="Directory to store figure"
    )
    parser.add_argument(
        '--whitelist',
        required=True,
        help='Provide path to the whitelist'
    )
    parser.add_argument(
        '--hephaestus',
        action="store_true",
        help='Process hephaestus results'
    )
    parser.add_argument(
        '--increase',
        action="store_true",
        help='Process hephaestus results and print increases'
    )
    parser.add_argument(
        '--classes',
        action="store_true",
        help='Process hephaestus results and print increases in classes'
    )
    # Parse the arguments
    args = parser.parse_args()
    assert os.path.exists(args.whitelist)
    assert not args.increase or args.hephaestus
    assert not args.classes or (args.hephaestus and args.increase)
    return args


def check(pkg, cls, whitelist):
    """
    Check if pkg or cls is in the provided whitelist
    """
    def check_pkg(pattern):
        if '*' in pattern and pkg.startswith(pattern[:-1]):
            return True
        if pkg == pattern:
            return True
        return False

    for pattern in whitelist:
        if ',' not in pattern and check_pkg(pattern):
            return True
        elif ',' in pattern:
            pkg2 = pattern.split(',')[0]
            cls2 = pattern.split(',')[1]
            if check_pkg(pkg2) and cls.startswith(cls2):
                return True
    return False


def read_csv(path, whitelist):
    """
    Read a CSV that includes coverage of a run.
    Return a dictionary for that run of the format:
        [(pkg, cls)][metric] => int
        or
        [total][metric] => int
    """
    def add_coverage(res, pkg, key, value):
        segs = pkg.split(".")
        while segs:
            pkg = ".".join(segs)
            res[pkg][key] += value
            segs = segs[:-1]

    res = defaultdict(lambda: defaultdict(lambda: 0))
    with open(path, 'r') as f:
        csvreader = csv.reader(f)
        next(csvreader)

        for row in csvreader:
            pkg = row[1]
            cls = row[2].split('.')[0]
            if check(pkg, cls, whitelist):
                branch_missed = row[3]
                branch_covered = row[4]
                line_missed = row[7]
                line_covered = row[8]
                function_missed = row[11]
                function_covered = row[12]
                add_coverage(res, pkg, "branch_missed", int(branch_missed))
                add_coverage(res, pkg, "branch_covered", int(branch_covered))
                add_coverage(res, pkg, "line_missed", int(line_missed))
                add_coverage(res, pkg, "line_covered", int(line_covered))
                add_coverage(res, pkg, "function_missed", int(function_missed))
                add_coverage(res, pkg, "function_covered", int(function_covered))
                res[(pkg, cls)]['branch_missed'] += int(branch_missed)
                res[(pkg, cls)]['branch_covered'] += int(branch_covered)
                res[(pkg, cls)]['line_missed'] += int(line_missed)
                res[(pkg, cls)]['line_covered'] += int(line_covered)
                res[(pkg, cls)]['function_missed'] += int(function_missed)
                res[(pkg, cls)]['function_covered'] += int(function_covered)
                res['total']['branch_missed'] += int(branch_missed)
                res['total']['branch_covered'] += int(branch_covered)
                res['total']['line_missed'] += int(line_missed)
                res['total']['line_covered'] += int(line_covered)
                res['total']['function_missed'] += int(function_missed)
                res['total']['function_covered'] += int(function_covered)

    return res


def compute_increase(res1, res2, cls=False):
    def get_increase(metric):
        metric = metric + '_covered'
        increase = res2[pkg][metric] - res1[pkg][metric]
        perc_incr = 0
        if res1[pkg][metric] > 0:
            perc_incr =  (increase / res1[pkg][metric]) * 100
        elif res2[pkg][metric] > 0:
            perc_incr = 9999999
        return perc_incr, increase

    res3 = defaultdict(lambda: defaultdict(lambda: 0))
    for pkg in res2.keys():
        if not cls and isinstance(pkg, tuple):
            continue
        if cls and not isinstance(pkg, tuple):
            continue
        branch_perc_incr, branch_incr = get_increase('branch')
        if branch_perc_incr <= 0:
            continue
        line_perc_incr, line_incr = get_increase('line')
        func_perc_incr, func_incr = get_increase('function')
        res3[pkg]['branch_covered'] = branch_incr
        res3[pkg]['branch_perc'] = branch_perc_incr
        res3[pkg]['line_covered'] = line_incr
        res3[pkg]['line_perc'] = line_perc_incr
        res3[pkg]['function_covered'] = func_incr
        res3[pkg]['function_perc'] = func_perc_incr
    return res3


def heph_grouped_bar_plot(heph, thalia, comb, output="figure.pdf"):
    # Convert data to DataFrame and transpose
    df = pd.DataFrame([heph, thalia, comb], index=['HEPHAESTUS', 'THALIA', 'Combination'])
    df = df[['line', 'branch', 'function']].T

    palette = sns.color_palette("Greys", len(df.columns))

    # Define bar width and space between bars
    bar_width = 0.15
    space_between_bars = 0.02

    # Define positions for each group
    positions = list(range(df.shape[0]))

    for i, (col_name, color) in enumerate(zip(df.columns, palette)):
        # Create new positions for this group of bars
        new_positions = [p + i*(bar_width + space_between_bars) for p in positions]
        plt.bar(new_positions, df[col_name], width=bar_width, color=color, edgecolor='white',
                label=col_name, align='edge')

    # Adjust x-ticks position to center
    centered_positions = [p + (bar_width+space_between_bars)*(len(df.columns))/2 for p in positions]

    plt.xticks(centered_positions, df.index, rotation=0)

    plt.legend(loc='lower left', ncol=int(len(df.columns)/2))

    plt.ylabel('Code coverage')  # Adjust as needed
    # Increase y-axis limit
    plt.ylim(0, 55)
    plt.xticks(rotation=0)
    plt.savefig(output, bbox_inches='tight')


def hephaestus(language, whitelist, increase=False, classes=False):
    path = os.path.join(HEPH_PATH, language + "-all.csv")
    heph_results = read_csv(path, whitelist)
    path = os.path.join(THALIA_PATH, language + "-all.csv")
    thalia_results = read_csv(path, whitelist)
    path = os.path.join(COMB_PATH, language + "-all.csv")
    comb_results = read_csv(path, whitelist)

    if increase:
        increase = compute_increase(heph_results, comb_results, classes)
        increase_view = [(
            v['branch_perc'],
            (k[0] + "," + k[1] if isinstance(k, tuple) else k,
            v['branch_covered'],
            v['line_covered'],
            v['line_perc'],
            v['function_covered'],
            v['function_perc']))
            for k,v in increase.items() ]
        increase_view.sort(reverse=True)
        for view in increase_view:
            print("{name}: Branch -- {ba} ({bp:.2f}), Line -- {la} ({lp:.2f}), Func -- {fa} ({fp:.2f})".format(
                name=view[1][0],
                ba=view[1][1],
                bp=view[0],
                la=view[1][2],
                lp=view[1][3],
                fa=view[1][4],
                fp=view[1][5]
            ))
    else:
        total_heph_results = {}
        total_thalia_results = {}
        total_comb_results = {}
        for metric in METRICS:
            covered = metric + "_covered"
            missed = metric + "_missed"
            print("Hephaestus")
            r = round((heph_results["total"][covered] / (heph_results["total"][covered]+heph_results["total"][missed])) * 100, 2)
            print(metric, r)
            total_heph_results[metric] = r
            print("Thalia")
            r = round((thalia_results["total"][covered]/ (thalia_results["total"][covered]+thalia_results["total"][missed])) * 100, 2)
            print(metric, r)
            total_thalia_results[metric] = r
            print("Combination")
            r = round((comb_results["total"][covered]/ (comb_results["total"][covered]+comb_results["total"][missed])) * 100, 2)
            print(metric, r)
            total_comb_results[metric] = r
        figure = os.path.join("figures",
                              "{}-cov-comparison.pdf".format(language))
        heph_grouped_bar_plot(total_heph_results,
                              total_thalia_results, total_comb_results, figure)



def plot_all_values_bar_chart(sorted_projects, stdlib_name,
                              output="figure.pdf", language=""):
    plt.style.use('default')
    #sns.set(style="whitegrid")
    plt.rcParams['font.monospace'] = 'Inconsolata Medium'
    plt.rcParams['font.size'] = 19
    plt.rcParams['axes.labelsize'] = 22
    plt.rcParams['axes.titlesize'] = 14
    plt.rcParams['xtick.labelsize'] = 19
    plt.rcParams['ytick.labelsize'] = 18
    plt.rcParams['legend.fontsize'] = 22
    plt.rcParams['figure.titlesize'] = 24
    plt.rcParams['figure.figsize'] = (8, 4)
    # Convert the data dictionary to a pandas DataFrame
    df = pd.DataFrame(sorted_projects).T

    # Get the 'all' column
    all_values = df['all']

    # Define the colors for the bars
    colors = ['#87acba' if index == 'combination' else '#f6bab2' if index == stdlib_name else 'dimgrey'
              for index in all_values.index]

    # Create a new figure
    _, ax = plt.subplots()

    # Set initial bar position
    bar_position = 0

    # Iterate over all_values, colors and their indices
    for i, (index, value, color) in enumerate(zip(all_values.index, all_values, colors)):
        # Determine the width of the bar
        width = 2 if index in [stdlib_name, 'combination'] else 1
        # Plot the bar
        plt.bar(bar_position, value, color=color, width=width, align='edge')
        # Update bar position
        bar_position += width

    # Add legend
    patches = [
        mpatches.Patch(color='#f6bab2', label='Stdlib'),
        mpatches.Patch(color='#87acba', label='All libs'),
    ]
    plt.legend(handles=patches, loc='lower left')
    plt.xlabel("Libraries")
    plt.ylabel("Line coverage")
    plt.yticks()

    # Remove x-axis labels
    plt.xticks([])
    total_cov = round(df.loc["combination"]["all"], 2)
    plt.axhline(y=total_cov,
                color='r', linestyle='dashed')

    # Adjust x-axis limits to remove extra spaces
    plt.xlim(-0.1, bar_position - 0.2)
    yticks = list(ax.get_yticks())
    if int(yticks[-1]) == int(total_cov):
        yticks = yticks[:-1] + [total_cov]
    else:
        yticks = yticks[:-2] + [total_cov] + [yticks[-1]]
    ax.set_yticks(yticks)
    plt.ylim([0, 55])

    # Save the plot to the output file
    plt.savefig(output, bbox_inches='tight')

    # Close the plot to release resources
    plt.close()

def plot_boxplots_libs(sorted_projects, output="figure.pdf"):
    # Prepare the data
    data = {mode: [info[mode] for info in sorted_projects.values()] for mode in ['base', 'base-erase', 'base-erase-inject', 'all']}
    df = pd.DataFrame(data)

    # Plot
    plt.figure(figsize=(10, 6))
    df.boxplot()

    plt.ylabel('Coverage')  # Adjust as needed
    plt.xticks(rotation=0)
    plt.savefig(output, bbox_inches='tight')
    plt.close()


def plot_percentage_increase_boxplots(language, sorted_projects):
    # Prepare the data
    base_values = np.array([info['base'] for info in sorted_projects.values()])
    modes = ['base-erase', 'base-inject', 'base-both']
    modes_map = {
            'base-erase': 'Erase',
            'base-inject': 'Inject',
            'base-both': 'Both'
    }
    data = defaultdict(list)
    for mode in modes:
        for info in sorted_projects.values():
            base = info["base"]
            mode_stats = info[mode]
            stats = mode_stats[0] - base[0], mode_stats[1] - base[1]
            data[modes_map[mode]].append(stats)

    df = pd.DataFrame(data)
    # Calculate statistics
    statistics = pd.DataFrame(index=['Min', 'Max', 'Median', 'Mean', 'Std'])
    for mode in modes_map.values():
        arr = [x[-1] for x in df[mode]]
        absolute = [x[0] for x in df[mode]]
        mean = np.mean(arr)
        median = np.median(arr)
        absolute_mean = np.mean(absolute)
        absolute_med = np.median(absolute)
        maximum = np.max(arr)
        absolute_max = absolute[arr.index(maximum)]
        minimum = np.min(arr)
        absolute_min = absolute[arr.index(minimum)]
        mean = round(mean, 2)
        median = round(median, 2)
        maximum = round(maximum, 2)
        minimum = round(minimum, 2)
        std_dev = round(np.std(arr), 2)
        statistics[mode] = [(minimum, absolute_min), (maximum, absolute_max),
                            (median, absolute_med), (mean, absolute_mean),
                            std_dev]

    # Print statistics table
    print(f"Table 4 ({language} data)".center(75))
    print(75 * "=")
    template = "{:<10}{:<15}{:<15}{:<15}{:<15}{:<10}"
    print(template.format("Mode", "Min", "Max", "Median", "Mean", "Std"))
    print(75 * "-")
    for key, values in statistics.items():
        print(template.format(
            key,
            f"+{values.iloc[0][1]}({values.iloc[0][0]}%)",
            f"+{values.iloc[1][1]}({values.iloc[1][0]}%)",
            f"+{values.iloc[2][1]}({values.iloc[2][0]}%)",
            f"+{int(round(values.iloc[3][1], 2))}({values.iloc[3][0]}%)",
            f"{values.iloc[4]}%",

        ))


def process_libs(coverage_dir, language, whitelist, output_dir,
                 metric="branch"):
    covered = metric + "_covered"
    missed = metric + "_missed"
    print("Processing coverage data per library...")

    lang_path = os.path.join(coverage_dir, language)
    projects = list(os.listdir(lang_path))
    results = defaultdict(dict)
    for project in projects:
        for mode in SORTED_MODES:
            path = os.path.join(lang_path, project, mode) + ".csv"
            if not os.path.exists(path):
                continue
            total = read_csv(path, whitelist)['total']
            perc = (total[covered] / (total[covered] + total[missed])) * 100
            results[project][mode] = (total[covered], perc)

    perc_results = {
        lib: {
            mode: entries[1]
            for mode, entries in data.items()
        }
        for lib, data in results.items()
    }

    sorted_results = dict(sorted(perc_results.items(),
                                 key=lambda x: x[1]["all"]))
    figure = os.path.join(output_dir, "{}-{}-libs.pdf".format(language, metric))
    plot_all_values_bar_chart(sorted_results, language + '-stdlib', figure,
                              language)
    plot_percentage_increase_boxplots(language, results)


def main():
    args = get_args()
    with open(args.whitelist) as f:
        whitelist = [line.strip() for line in f.readlines()]

    if args.hephaestus:
        hephaestus(args.language, whitelist, args.increase, args.classes)
    else:
        for metric in ["line"]:
            process_libs(args.coverage_data, args.language, whitelist,
                         args.output_dir, metric)


if __name__ == "__main__":
    main()

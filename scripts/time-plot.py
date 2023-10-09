import argparse
import os

import seaborn as sns
import matplotlib.pylab as plt
import matplotlib.ticker as ticker
import pandas as pnd

import numpy as np

sns.set(style="whitegrid")
plt.rcParams['font.monospace'] = 'Inconsolata Medium'
plt.rcParams['font.size'] = 22
plt.rcParams['axes.labelsize'] = 20
plt.rcParams['xtick.labelsize'] = 19
plt.rcParams['ytick.labelsize'] = 19
plt.rcParams['legend.fontsize'] = 22
plt.rcParams['figure.titlesize'] = 24
plt.rcParams['figure.figsize'] = (8, 4)


def format_thousands(x, pos):
    """Formatter function to display thousands with 'k'."""""
    return f"{x/1000:.0f}k"


def get_args():
    parser = argparse.ArgumentParser(
        description='Create regression plots of synthesis time')
    parser.add_argument("input", help="Directory with time distributions")
    parser.add_argument("output", type=str,
                        help='Directory to store regression plots')
    return parser.parse_args()


def draw_regression_plot(lang, input_dir, output_dir):
    data = {
        "Library": [],
        "Time": [],
        "Size": [],
    }
    with open(os.path.join(input_dir, f"{lang}-time.csv")) as f:
        for line in f:
            segs = line.split(",")
            lib, size, time = segs[0], int(segs[1]), float(segs[2])
            data["Library"].append(lib)
            data["Size"].append(size)
            data["Time"].append(time * 1000)

    print(f"({lang}) Average synthesis time: {round(np.mean(data['Time']))}ms")

    df = pnd.DataFrame(data)
    ax = sns.regplot(x="Size", y="Time", data=df, scatter=True, color="black",
                     scatter_kws={'alpha': 1.0, 's': 8},
                     line_kws={'linewidth': 1, 'linestyle': '--'})
    plt.ylabel('Synthesis Time (ms)')
    plt.xlabel('API Graph Size')
    plt.ylim([0, 900])
# Apply the formatter to the x-axis ticks
    ax.xaxis.set_major_formatter(ticker.FuncFormatter(format_thousands))
    plot_file = os.path.join(output_dir, f"{lang}-time.pdf")
    plt.savefig(plot_file, format='pdf', bbox_inches='tight',
                pad_inches=0)
    plt.clf()


args = get_args()
draw_regression_plot("groovy", args.input, args.output)
draw_regression_plot("scala", args.input, args.output)
draw_regression_plot("kotlin", args.input, args.output)

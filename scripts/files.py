import argparse
import os

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import seaborn as sns


sns.set(style="whitegrid")
plt.rcParams['font.monospace'] = 'Inconsolata Medium'
plt.rcParams['font.size'] = 14
plt.rcParams['axes.labelsize'] = 22
plt.rcParams['axes.titlesize'] = 20
plt.rcParams['xtick.labelsize'] = 19
plt.rcParams['ytick.labelsize'] = 19
plt.rcParams['legend.fontsize'] = 22
plt.rcParams['figure.titlesize'] = 24
plt.rcParams['figure.figsize'] = (6, 4)

languages = ['groovy', 'kotlin', 'scala']
old_modes = ['base', 'erase', 'inject', 'both']
new_modes = ['Well-typed', 'Ill-typed']

# Create a list to store the dataframes
dfs = []


def get_args():
    parser = argparse.ArgumentParser(
        description='Create box plots representing the files synthesized by Thalia')
    parser.add_argument("dir", help="Directory of file results")
    parser.add_argument("figure", help="Path to save the figure")
    return parser.parse_args()


def format_thousands(x, pos):
    """Formatter function to display thousands with 'k'."""""
    return f"{x/1000:.0f}k"


args = get_args()
for language in languages:
    # Read the data
    df = pd.read_csv(os.path.join(args.dir, f"{language}.csv"))
    # Find packages that have entries for all old_modes
    packages_with_all_modes = df['package'][df['mode'].isin(old_modes)].value_counts() == len(old_modes)
    packages_with_all_modes = packages_with_all_modes[packages_with_all_modes].index.tolist()

    # Filter the dataframe to include only those packages
    df = df[df['package'].isin(packages_with_all_modes)]

    # Combine "base" and "erase" modes into "Well-typed", and "inject" and "both" into "Ill-typed"
    df['mode'] = df['mode'].replace(['base', 'erase'], 'Well-typed')
    df['mode'] = df['mode'].replace(['inject', 'both'], 'Ill-typed')

    # Add a new column for language
    df['language'] = language.capitalize()

    # Append the dataframe to dfs list
    dfs.append(df)

# Concatenate all dataframes in the list
all_data = pd.concat(dfs, ignore_index=True)

# Print the statistics for 'files' column grouped by 'mode' and 'language'
print(all_data.groupby(['mode', 'language'])['files'].describe()[[
    "mean", "std", "min", "25%", "50%", "75%", "max"]])

# Plot box plot with smaller bars
plt.figure()
ax = sns.boxplot(x="mode", y="files", hue="language", data=all_data,
                 palette="Greys", linewidth=1.5, width=0.6)

plt.xlabel('')
plt.ylabel('Programs')
plt.xticks()
plt.yticks()
plt.legend()

plt.ylim(-400, 35000)
ax.yaxis.set_major_formatter(ticker.FuncFormatter(format_thousands))
plt.savefig(args.figure, bbox_inches='tight')
plt.close()

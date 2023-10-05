import argparse
import json
from collections import defaultdict

import seaborn as sns
from matplotlib import pylab as plt
from matplotlib_venn import venn3


plt.style.use('ggplot')
sns.set(style="whitegrid")
plt.rcParams['font.size'] = 22
plt.rcParams['font.monospace'] = 'Inconsolata Medium'
plt.rcParams['figure.figsize'] = (6, 5)
plt.rcParams['axes.labelsize'] = 22


features_lookup = {
    # Declarations
    "Access modifier": ("Declaration", None, False),
    "Variable argument": ("Declaration", None, True),
    "Parameterized function": ("Declaration", "Parametric polymorphism", True),
    "Parameterized class": ("Declaration", "Parametric polymorphism", True),
    "Default method": ("Declaration", None, False),
    "Bridge method":  ("Declaration", "Parametric polymorphism", False),
    "Static method": ("Declaration", None, False),
    "Overloading": ("Declaration", "Overloading", False),
    "Operator": ("Declaration", None, False),
    "Single Abstract Method (SAM)": ("Declaration", "Functional programming", True),
    "Inheritance / Implementation of multiple interfaces": ("Declaration", None, False),
    "Inner class": ("Declaration", None, False),

    # Types
    "Parameterized type": ("Type", "Parametric polymorphism", True),
    "Wildcard type": ("Type", "Parametric polymorphism", True),
    "Bounded type parameter": ("Type", "Parametric polymorphism", True),
    "Recursive upper bound": ("Type", "Parametric polymorphism", False),
    "Subtyping": ("Type", None, True),
    "Primitive type": ("Type", None, True),
    "Array type": ("Type", None, True),
    "Nullable type": ("Type", None, False),

    # Expressions
    "Lambda": ("Expression", "Functional programming", True),
    "Function reference": ("Expression", "Functional programming", True),
    "Conditionals": ("Expression", None, True),

    # Type inference
    "Type argument inference": ("Type inference", "Type inference", True),
    "Variable type inference": ("Type inference", "Type inference", True),
}


def get_args():
    parser = argparse.ArgumentParser(
        description='Compute statistics for the bugs.')
    parser.add_argument("input", help="File with bugs.")
    parser.add_argument("--venn", type=str,
                        help='Create Venn diagram')
    return parser.parse_args()


def process(bugs):
    features = defaultdict(lambda: 0)
    combinations = defaultdict(lambda: defaultdict(lambda: 0))
    categories = defaultdict(set)
    for bug in bugs:
        bcategories = set()
        for feature in bug['chars']['characteristics']:
            features[feature] += 1
            cat = features_lookup[feature][1]
            if cat is not None:
                bcategories.add(cat)
            for comb in bug['chars']['characteristics']:
                if feature != comb:
                    combinations[feature][comb] += 1
        for cat in bcategories:
            categories[cat].add(bug["bugid"])
    return features, combinations, categories


def to_records(features):
    categories = [
        "Declaration",
        "Type inference",
        "Type",
        "Expression"
    ]
    records = []
    for cat in categories:
        for feature, freq in features.items():
            category, _, supported = features_lookup[feature]
            if cat == category:
                records.append((cat, feature, freq, supported))
    sorted_data = sorted(records,
                         key=lambda x: (categories.index(x[0]), -x[2]))
    return sorted_data


def show_features(records, total_bugs):
    template = "{:<20}{:<53}{:<10}{:<5}"
    print("Table 3".center(100))
    print(93 * "=")
    print(template.format("Category", "Feature", "Frequency", "Supported"))
    print(93 * "-")
    for cat, feature, freq, supported in records:
        print(template.format(cat, feature, f"{freq} / {total_bugs}",
                              "Yes" if supported else "No"))


def main():
    args = get_args()
    with open(args.input, 'r') as f:
        data = json.load(f)
    features, _, categories = process(data)
    records = to_records(features)
    for cat, val in categories.items():
        print(cat, len(val))
    if args.venn:
        venn3([categories["Parametric polymorphism"],
               categories["Overloading"],
               categories["Functional programming"]],
              ("Parametric polymorpism", "Overloading",
               "Functional programming"))
        plt.savefig(args.venn, format='pdf', bbox_inches='tight',
                    pad_inches=0)
    show_features(records, len(data))


if __name__ == "__main__":
    main()

import argparse
import os
import json
import pandas as pd


def get_base():
    return {
        'heph': {
            'compilation': 0,
            'generation': 0,
            'batches': 0,
            'total': 0
        },
        'thalia': {
            'compilation': 0,
            'generation': 0,
            'batches': 0,
            'total': 0
        },
    }


def get_args():
    parser = argparse.ArgumentParser(
        description=('Compute table that compares the synthesis and '
                     'compilation time of Thalia and Hephaestus'))
    parser.add_argument("input", help="Directory containing time data")
    return parser.parse_args()


args = get_args()
base_dir = args.input
results = {}
for lang in ["groovy", "scala", "kotlin"]:
    results[lang] = get_base()

# Iterate over the tools (heph and thalia)
for tool in ['heph', 'thalia']:
    tool_dir = os.path.join(base_dir, tool)

    # Iterate over the modes (compilation and generation)
    for mode in ['compilation', 'generation']:
        mode_dir = os.path.join(tool_dir, mode)

        # Iterate over the languages
        for language in os.listdir(mode_dir):
            language_dir = os.path.join(mode_dir, language)

            # Initialize counters for passed and failed
            passed = 0
            failed = 0

            # Iterate over the JSON files in the language directory
            for filename in os.listdir(language_dir):
                file_path = os.path.join(language_dir, filename)

                # Read the JSON file
                with open(file_path, 'r') as f:
                    data = json.load(f)

                if mode == 'generation':
                    results[language][tool]['total'] += data['totals']['passed'] + data['totals']['failed']
                else:
                    results[language][tool]['batches'] += data['batches']
                results[language][tool][mode] += data['time']


df = pd.DataFrame(results).stack().apply(pd.Series)
df = df.reset_index()
df.columns = ['Language', 'Tool', 'Compilation', 'Generation', 'Batches', 'Total']
df['Compilation Mean'] = df['Compilation'] / df['Batches']
df['Generation Mean'] = df['Generation'] / df['Total']
df = df[['Language', 'Tool', 'Compilation Mean', 'Generation Mean']]

template = "{:<15}{:<20}{:<20}{:<20}{:<20}"
print("Table 5".center(90))
print(90 * "=")
print(template.format("Compiler", "Thalia (comp)", "Hephaestus (comp)", "Thalia (gen)", "Hephaestus (gen)"))
print(90 * "-")
for lang, val in results.items():
    comp_thalia = round(val["thalia"]["compilation"] / val["thalia"]["batches"], 1)
    gen_thalia = round(val["thalia"]["generation"] / val["thalia"]["total"], 1)
    comp_hephaestus = round(val["heph"]["compilation"] / val["heph"]["batches"], 1)
    gen_hephaestus = round(val["heph"]["generation"] / val["heph"]["total"], 1)
    print(template.format(
        lang, comp_thalia, comp_hephaestus, gen_thalia, gen_hephaestus
    ))

import argparse
import os
import json
from pathlib import Path


def get_args():
    parser = argparse.ArgumentParser(
        description='Extract and merge compilation time results')
    parser.add_argument("--input", help="Directory of generated programs",
                        required=True)
    parser.add_argument("--output", help="Directory to output of json files",
                        required=True)
    return parser.parse_args()


args = get_args()
input_dir = args.input
outdir = args.output


# Initialize the totals
totals = {
    'base': {
        'totals':{
            'passed': 0,
            'failed': 0,
         },
         'time': 0.0
     },
    'erase': {
        'totals':{
            'passed': 0,
            'failed': 0,
         },
         'time': 0.0
     },
    'inject': {
        'totals':{
            'passed': 0,
            'failed': 0,
         },
         'time': 0.0
     },
    'both': {
        'totals':{
            'passed': 0,
            'failed': 0,
         },
         'time': 0.0
     }
}

# Iterate over the JSON files
for project in os.listdir(input_dir):
    mode = project.split('-')[-1]
    file_path = os.path.join(input_dir, project, "stats.json")
    with open(file_path) as file:
        data = json.load(file)
        totals[mode]['totals']['passed'] += data['totals']['passed']
        totals[mode]['totals']['failed'] += data['totals']['failed']
        totals[mode]['time'] += data.get('synthesis_time', data.get("time", 0))


for mode, data in totals.items():
    filepath = os.path.join(outdir, mode + '.json')
    os.makedirs(Path(filepath).parent.absolute(), exist_ok=True)
    with open(filepath, 'w') as output_file:
        json.dump(data, output_file, indent=4)

import argparse
import os
import json
from pathlib import Path


def get_args():
    parser = argparse.ArgumentParser(
        description='Extract and merge synthesis time results')
    parser.add_argument("--input", help="Directory of generated programs",
                        required=True)
    parser.add_argument("--output", help="Directory to output of json files",
                        required=True)
    parser.add_argument("--batch", help="Size of each batch", type=int,
                        required=True)
    return parser.parse_args()


args = get_args()
input_dir = args.input
outdir = args.output
batch_size = args.batch


# Initialize the totals
totals = {
    'base': {
         'batches': 0,
         'time': 0.0
     },
    'erase': {
         'batches': 0,
         'time': 0.0
     },
    'inject': {
         'batches': 0,
         'time': 0.0
     },
    'both': {
         'batches': 0,
         'time': 0.0
     }
}

# Iterate over the JSON files
for project in os.listdir(input_dir):
    mode = project.split('-')[-1]
    file_path = os.path.join(input_dir, project, "stats.json")
    with open(file_path) as file:
        data = json.load(file)
        passed = data['totals']['passed']
        failed = data['totals']['failed']
        programs = passed + failed
        totals[mode]['batches'] = programs / batch_size
        totals[mode]['time'] += data['compilation_time']


for mode, data in totals.items():
    filepath = os.path.join(outdir, mode + '.json')
    os.makedirs(Path(filepath).parent.absolute(), exist_ok=True)
    with open(filepath, 'w') as output_file:
        json.dump(data, output_file, indent=4)

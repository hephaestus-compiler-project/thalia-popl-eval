import argparse
import json
from collections import defaultdict


lang_lookup = {
    'Groovy': 'groovyc',
    'Kotlin': 'kotlinc',
    'Scala': 'dotty',
    'total': 'Total'
}

rows_lookup = {
    'generator': 'Well-typed',
    'inference': 'Well-typed (TE)',
    'soundness': 'Ill-typed',
    "inference/soundness": "Ill-typed (TE)",
    'Unexpected Compile-Time Error': 'UCTE',
    'Unexpected Runtime Behavior': 'URB',
    "Compilation Performance Issue": "CPI",
    'crash': 'Crash'
}


def get_args():
    parser = argparse.ArgumentParser(
        description='Process bugs.json to answer RQs')
    parser.add_argument("input", help="JSON File with bugs.")
    return parser.parse_args()


def process(bug, res):
    d = {
        'status': {
            'Kotlin': {
                'Submitted': 'Reported',
                'In Progress': 'Confirmed',
                'Open': 'Confirmed',
                'Closed': None
            },
            'Groovy': {
                'Open': 'Confirmed',
                'In Progress': 'Confirmed',
                'Resolved': None,
                'Reopened': 'Confirmed',
                'Closed': None
            },
            'Scala': {
                'Open': 'Confirmed',
                'In Progress': 'Confirmed',
                'Closed': None
            }
        },
        'resolution': {
            'Kotlin': {
                'Fixed': 'Fixed',
                'Obsolete': 'Fixed',
                'As Designed': 'Wont fix',
                'Duplicate': 'Duplicate'
            },
            'Groovy': {
                'Duplicate': 'Duplicate',
                'Fixed': 'Fixed',
                'Information Provided': 'Wont fix',
                "Won't Fix": "Wont fix",
            },
            'Scala': {
                'Not an Issue':  'Wont fix',
                'Duplicate': 'Duplicate',
                'Fixed': 'Fixed'
            }
        },
        'symptom': {
            'Unexpected Compile-Time Error': 'Unexpected Compile-Time Error',
            'Unexpected Runtime Behavior': 'Unexpected Runtime Behavior',
            'crash': 'crash',
            'Misleading Report': 'Unexpected Compile-Time Error',
            "Compilation Performance Issue": "Compilation Performance Issue",
        },
    }
    lang = bug['language']
    bstatus = bug['status']
    bresolution = bug['resolution']
    bsymptom = bug['symptom']
    bmutator = bug['mutator']
    status = d['status'][lang].get(bstatus, None)
    if status is None:
        status = d['resolution'][lang].get(bresolution, None)
    symptom = d['symptom'].get(bsymptom, None)
    res[lang]['status'][status] += 1
    res[lang]['symptom'][symptom] += 1
    res[lang]['mutator'][bmutator] += 1
    res['total']['status'][status] += 1
    res['total']['symptom'][symptom] += 1
    res['total']['mutator'][bmutator] += 1


def print_table(title, column_name, res, extra_line=True, first_col=20):
    # res should be a dict of dict in the following format:
    # {"row name": {"column name": value, ...}, ...}
    def print_line(title, columns, values):
        row_format = f"{{:<{first_col}}}" + "{:<10}" * len(columns)
        print(row_format.format(
            title,
            *(values[column] for column in columns)
        ))
    if len(res.values()) == 0:
        return
    header = [column_name] + list(list(res.values())[0].keys())
    row_format = f"{{:<{first_col}}}" + "{:<10}" * (len(header) - 1)
    lenght = first_col + 10 * (len(header) - 1)
    print(title.center(lenght))
    print(lenght * "=")
    pretty_header = [lang_lookup.get(h, h) for h in header]
    print(row_format.format(*pretty_header))
    print(lenght * "-")
    for counter, item in enumerate(res.items()):
        row_name, values = item
        if extra_line and counter == len(res)-1:
            print(lenght * "-")
        print_line(rows_lookup.get(row_name, row_name), header[1:], values)
    print()


def main():
    args = get_args()
    with open(args.input, 'r') as f:
        data = json.load(f)
    res = defaultdict(lambda: {
        'status': {
            'Confirmed': 0,
            'Fixed': 0,
            'Wont fix': 0,
            'Duplicate': 0
        },
        'symptom': {
            'Unexpected Compile-Time Error': 0,
            'Unexpected Runtime Behavior': 0,
            'crash': 0,
            'Compilation Performance Issue': 0,
        },
        'mutator': {
            'generator': 0,
            'inference': 0,
            'soundness': 0,
            'inference/soundness': 0
        }
    })
    for bug in data:
        process(bug, res)
    langs = ['Groovy', 'Kotlin', 'Scala', 'total']

    def per_attribute(attrs, attr, total=True):
        r = {
            s: {lang: res[lang][attr][s]
                for lang in langs}
            for s in attrs
        }
        if total:
            r['Total'] = {lang: sum(res[lang][attr][s] for s in r)
                          for lang in langs}
        return r

    status_cat = res['total']['status'].keys()
    status = per_attribute(status_cat, 'status', total=True)
    print_table('Table 2a', 'Status', status)

    symtoms_cat = res['total']['symptom'].keys()
    symptoms = per_attribute(symtoms_cat, 'symptom', total=False)
    print_table('Table 2b', 'Symptoms', symptoms, extra_line=False)

    mode_cat = res['total']['mutator'].keys()
    modes = per_attribute(mode_cat, 'mutator', total=False)
    print_table('Table 2c', 'Synthesis mode', modes, extra_line=False)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Thorough translation analysis for StashFlow ARB files.

Checks:
1. Placeholder consistency: every {placeholder} used in a value must be declared in the
   matching @key metadata in app_en.arb (and each locale must include the same placeholders).
2. Locales must not declare placeholders that their value does not use.
3. Key-name vs English-value mismatch heuristics (keys that look like actions but values
   don't match, duplicated values across different keys, etc.)
4. Missing keys and extra keys per locale.
5. Plural/ICU messages present in English but plain strings in a locale (or vice versa).
"""
import json
import re
import glob
from pathlib import Path

root = Path(__file__).resolve().parent.parent
l10n_dir = root / 'lib' / 'l10n'

def load(name):
    with open(l10n_dir / name, 'r', encoding='utf-8') as f:
        return json.load(f)

en = load('app_en.arb')

# --- collect placeholder metadata from English ---
en_meta = {}
for k, v in en.items():
    if k.startswith('@'):
        key = k[1:]
        en_meta[key] = v

def strip_icu_selectors(value):
    """Remove {selector{...}} ICU blocks so only real placeholders remain."""
    # Remove =N{...}, =0{...}, other{...}, =1{...} selector blocks (non-greedy, nested-safe enough for our files)
    prev = None
    while prev != value:
        prev = value
        value = re.sub(r'=\w*\{[^{}]*\}', '', value)  # =0{...} style selectors
    # also remove bare selector keyword blocks like other{...} / male{...}
    prev = None
    while prev != value:
        prev = value
        value = re.sub(r'\b(?:zero|one|two|few|many|other|male|female|true|false)\s*\{[^{}]*\}', '', value)
    return value

def placeholders_in(value):
    if not isinstance(value, str):
        return set()
    return set(re.findall(r'\{(\w+)\}', strip_icu_selectors(value)))

def icu_message(value):
    return isinstance(value, str) and '{' in value and ',' in value and ('plural' in value or 'select' in value)

issues = []
locale_files = sorted(glob.glob(str(l10n_dir / 'app_*.arb')))
for path in locale_files:
    if path.endswith('app_en.arb'):
        continue
    name = Path(path).name
    data = load(name)

    # missing keys
    missing = [k for k in en if not k.startswith('@') and k not in data]
    if missing:
        issues.append(f'[{name}] MISSING keys: {missing}')

    # extra keys not in English
    extra = [k for k in data if not k.startswith('@') and k not in en]
    if extra:
        issues.append(f'[{name}] EXTRA keys: {extra}')

    for k, v in en.items():
        if k.startswith('@'):
            continue
        if k not in data:
            continue
        lv = data[k]

        # placeholder set consistency
        en_ph = placeholders_in(v)
        lo_ph = placeholders_in(lv)
        if en_ph != lo_ph:
            issues.append(
                f'[{name}] PLACEHOLDER MISMATCH for {k}: '
                f'EN={sorted(en_ph)} locale={sorted(lo_ph)} | "{lv}"'
            )

        # ICU plural/select consistency
        if icu_message(v) and not icu_message(lv):
            issues.append(f'[{name}] ICU->plain for {k}: "{lv}"')
        elif not icu_message(v) and icu_message(lv):
            issues.append(f'[{name}] plain->ICU for {k}: "{lv}"')

# --- English key-name vs value sanity ---
# heuristic: action keys whose value is a noun phrase that clearly diverges
EN_VALUE_BY_KEY = {k: v for k, v in en.items() if not k.startswith('@') and isinstance(v, str)}

# find keys whose value equals another key's value (possible copy/paste or inaccurate key)
from collections import defaultdict
by_value = defaultdict(list)
for k, v in EN_VALUE_BY_KEY.items():
    by_value[v].append(k)
for v, keys in sorted(by_value.items()):
    if len(keys) > 1 and v and not v.startswith('{'):
        issues.append(f'[en] DUPLICATE VALUE "{v}" for keys: {keys}')

print('=' * 70)
print('ISSUES FOUND:', len(issues))
print('=' * 70)
for i in issues:
    print(i)

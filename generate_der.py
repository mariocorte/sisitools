import re, pathlib

SQL_FILE = 'ddl.sql'
OUT_DOT = 'der.dot'

sql = pathlib.Path(SQL_FILE).read_text(encoding='utf-8')
pat = re.compile(r'CREATE TABLE\s+public\.(\w+)\s*\((.*?)\);', re.S)

tables = {}
pks = {}
for table, body in pat.findall(sql):
    cols = []
    for raw in body.splitlines():
        line = raw.strip().rstrip(',')
        if not line or line.startswith('--'):
            continue
        if line.startswith('CONSTRAINT'):
            m = re.search(r'PRIMARY KEY \(([^)]+)\)', line)
            if m:
                pks[table] = [c.strip() for c in m.group(1).split(',')]
            continue
        cols.append(line.split()[0])
    tables[table] = cols

relations = []
for table, cols in tables.items():
    for col in cols:
        for ref_table, ref_pk in pks.items():
            if table != ref_table and len(ref_pk) == 1 and col == ref_pk[0]:
                relations.append((table, ref_table, col))

lines = [
    'digraph ERD {',
    '  rankdir=LR;',
    '  graph [splines=ortho, nodesep=0.5, ranksep=1.1];',
    '  node [shape=record, fontsize=9, fontname="Helvetica"];',
    '  edge [fontsize=8, fontname="Helvetica"];',
]

for table in sorted(tables):
    pkset = set(pks.get(table, []))
    fields = [f"{'PK ' if c in pkset else ''}{c}" for c in tables[table]]
    label = '{' + table + '|' + r'\l'.join(fields) + r'\l}'
    attrs = [f'label="{label}"']
    if table in ('inccabecera', 'incaccion'):
        attrs += ['style="filled,bold"', 'fillcolor="#ffe8a3"', 'penwidth=2']
    lines.append(f"  {table} [{', '.join(attrs)}];")

if 'inccabecera' in tables and 'incaccion' in tables:
    lines.append('  { rank=same; inccabecera; incaccion; }')

for t, r, c in relations:
    lines.append(f'  {t} -> {r} [label="{c}", arrowsize=0.6, color="#777"];')

lines.append('}')
pathlib.Path(OUT_DOT).write_text('\n'.join(lines), encoding='utf-8')
print(f'Generated {OUT_DOT} with {len(tables)} tables and {len(relations)} inferred relations.')
print('To export JPG locally: dot -Tjpg der.dot -o der.jpg')

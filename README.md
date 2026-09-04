# ChEBI Element Extension Ontology

This repository contains an ontology component that injects axioms for the
atomic numbers for the atoms in ChEBI's
[atom (CHEBI:33250)](https://www.ebi.ac.uk/chebi/CHEBI:33250) hierarchy.

It uses the
[Chemical Entity Materials and Reactions Ontological Framework (CHEMROF)](https://semantic.farm/registry/chemrof)
to assign a reusable data property -
[`ChEMROF:atomic_number`](https://chemkg.github.io/chemrof/atomic_number/).

The results are available as a ROBOT template TSV (which can be used as a
regular TSV) and an OWL file. Rebuild with:

```console
$ just convert
```

### How does the template work?

[ROBOT is an OBO Tool (ROBOT)](https://robot.obolibrary.org/)

The primary curated artifact in this repository is
[src/elements.tsv](src/elements.tsv), which is a tab-separated values file that
can be used with [`robot template`](https://robot.obolibrary.org/template.html).

The secret is that there are two header rows. The first is purely for human
readability. The second give ROBOT commands.

1. `ID` says that this is the CURIE for the entity that we're annotating
2. `TYPE` says what kind of entity it is and how it should get declared. Either
   an informal abbreviation `class` or fully qualified CURIE `owl:Class` can be
   used
3. `label` having a label column is important to make this file readable, but I
   actually didn't want to add label axioms this way. The issue is this TSV
   could get out of sync with the upstream, especially because I suggested
   several of the relevant classes get their names improved in
   https://github.com/ebi-chebi/ChEBI/issues/4958 while I was working on this.
   As an alternative, these can be slurped from the current OWL file and merged
   (future work)
4. `atomic number` this is the coolest part of what's going on in this file.
   `SC 'ChEMROF:atomic_number' value %` has four parts:
   1. `SC` means that this is going to be a subclass expression
   2. [`ChEMROF:atomic_number`](https://chemkg.github.io/chemrof/atomic_number/)
      is the predicate in the expression. Quotes around the CURIE are required!
   3. `value` signals it's going to be a literal
   4. `%` is the placeholder for the value in each row

|             |       |               |                                    |
| ----------- | ----- | ------------- | ---------------------------------- |
| ID          | TYPE  | label         | atomic number                      |
| ID          | TYPE  |               | SC 'ChEMROF:atomic_number' value % |
| CHEBI:49637 | class | hydrogen atom | 1                                  |

Importantly, when running the `robot template` command, all the prefixes used
(which is just `CHEBI` and `ChEMROF`) need to get qualified. That is taken care
of in the [`justfile`](justfile), which is used to actually run ROBOT.

Because of the flexibility of the ROBOT templating language, this TSV can
effectively be used as a normal TSV, e.g., to programmatically get the mapping
from ChEBI identifiers to atomic numbers without going through OWL software.

## License

CC0

## Funding

NFDI4Chem (DFG Grant
[441958208](https://gepris.dfg.de/gepris/projekt/441958208))

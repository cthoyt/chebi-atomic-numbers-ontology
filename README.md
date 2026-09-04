# ChEBI Atomic Numbers Ontology

This repository contains an ontology component that injects axioms for the
atomic numbers for the atoms in ChEBI's
[atom (CHEBI:33250)](https://www.ebi.ac.uk/chebi/CHEBI:33250) hierarchy.

The resulting ontology artifact is available from
[https://github.com/cthoyt/chebi-atomic-numbers-ontology/raw/refs/heads/main/chebi-atomic-numbers.owl](https://github.com/cthoyt/chebi-atomic-numbers-ontology/raw/refs/heads/main/chebi-atomic-numbers.owl)
(PURL coming soon).

## How does this work?

The primary manually curated artifact in this repository is
[src/elements.tsv](src/elements.tsv), a tab-separated values (TSV) file that
contains templating information in its header that directs
[ROBOT](https://robot.obolibrary.org) how to convert it into an ontology file.

The first few lines look like this:

|             |       |               |                                    |
| ----------- | ----- | ------------- | ---------------------------------- |
| ID          | type  | label         | atomic number                      |
| ID          | TYPE  |               | SC 'ChEMROF:atomic_number' value % |
| CHEBI:49637 | class | hydrogen atom | 1                                  |

Note that there are two header rows: the first contains labels and the second
contains ROBOT commands. Here's what each means:

1. The `ID` command says that this column contains the CURIE for the entity
   we're annotating. We write `ID` in both the human label and the ROBOT command
   here to reduce confusion.
2. `TYPE` says what kind of entity it is and how it should get declared. Either
   an informal abbreviation `class` or fully qualified CURIE `owl:Class` can be
   used in this column
3. `label` having a label column is important to make this file readable, but I
   actually didn't want to add label axioms this way. The issue is this TSV
   could get out of sync with the upstream, especially because I suggested
   several of the relevant classes get their names improved in
   https://github.com/ebi-chebi/ChEBI/issues/4958 while I was working on this.
   As an alternative, these can be slurped from the current OWL file and merged
   (future work). If I wanted to include this, I would add
   `AT rdfs:label^^xsd:string`.
4. `atomic number` this is the coolest part of what's going on in this file.
   `SC 'ChEMROF:atomic_number' value %` has four parts:
   1. `SC` means that this is going to be a subclass expression
   2. [`ChEMROF:atomic_number`](https://chemkg.github.io/chemrof/atomic_number/)
      is the data property from the
      [Chemical Entity Materials and Reactions Ontological Framework (CHEMROF)](https://semantic.farm/registry/chemrof)
      used in the expression. Quotes around the CURIE are required!
   3. `value` signals it's going to be a literal
   4. `%` is the placeholder for the value in each row

The results are OWL that look like this (shown in OFN for brevity):

```
SubClassOf(CHEBI:49637 DataHasValue(ChEMROF:atomic_number> "1"^^xsd:integer))
...
SubClassOf(CHEBI:18248 DataHasValue(ChEMROF:atomic_number> "26"^^xsd:integer))
...
```

Because of the flexibility of the ROBOT templating language, this TSV can
effectively be used as a normal TSV, e.g., to programmatically get the mapping
from ChEBI identifiers to atomic numbers without going through OWL software.

## How to make the ontology export

The usage of [`robot template`](https://robot.obolibrary.org/template.html) is
encoded in this repository's [`justfile`](justfile). This does the following:

1. Qualifies all prefixes used (CHEBI and ChEMROF)
2. Merges in metadata from a different ontology file
   [`src/metadata.ofn`](src/metadata.ofn)
3. Adds declaration information for the data property that doesn't appear in
   `entities.tsv`

These can all be re-run with:

```console
$ just convert
```

## License

CC0

## Funding

NFDI4Chem (DFG Grant
[441958208](https://gepris.dfg.de/gepris/projekt/441958208))

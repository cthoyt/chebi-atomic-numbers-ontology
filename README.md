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

## License

CC0

## Funding

NFDI4Chem

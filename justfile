convert:
    robot template \
      --prefix "CHEBI: http://purl.obolibrary.org/obo/CHEBI_" \
      --prefix "ChEMROF: https://chemkg.github.io/chemrof/" \
      --ontology-iri https://github.com/cthoyt/chebi-element-extension-ontology/raw/refs/heads/main/elements.owl \
      --template properties.tsv \
      --template elements.tsv \
      --output elements.owl

convert:
    robot template \
      --prefix "CHEBI: http://purl.obolibrary.org/obo/CHEBI_" \
      --prefix "ChEMROF: https://chemkg.github.io/chemrof/" \
      --template properties.tsv \
      --template elements.tsv \
      --output tmp.owl
    robot merge \
      --input metadata.ofn \
      --input tmp.owl \
      --output elements.owl

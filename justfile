format:
    npx --yes prettier --check --prose-wrap always --write '**/*.md'

convert:
    robot template \
      --prefix "CHEBI: http://purl.obolibrary.org/obo/CHEBI_" \
      --prefix "ChEMROF: https://chemkg.github.io/chemrof/" \
      --template src/properties.tsv \
      --template src/elements.tsv \
      --output src/tmp.owl
    robot merge \
      --input src/metadata.ofn \
      --input src/tmp.owl \
      --output elements.owl

format:
    npx --yes prettier --check --prose-wrap always --write '**/*.md'

download-chebi:
    if [ ! -f src/chebi.owl ]; then \
        wget \
            https://ftp.ebi.ac.uk/pub/databases/chebi/ontology/chebi.owl \
            -O src/chebi.owl; \
    fi

extract: download-chebi
    ROBOT_JAVA_ARGS="-Djdk.xml.maxGeneralEntitySizeLimit=10000000 -Djdk.xml.totalEntitySizeLimit=10000000" robot extract \
      --input src/chebi.owl \
      --method MIREOT \
      --branch-from-term CHEBI:33250 \
      --output src/chebi_33250.ofn

convert:
    robot template \
      --prefix "CHEBI: http://purl.obolibrary.org/obo/CHEBI_" \
      --prefix "ChEMROF: https://chemkg.github.io/chemrof/" \
      --template src/properties.tsv \
      --template src/elements.tsv \
      --output src/elements.ofn
    robot merge \
      --input src/metadata.ofn \
      --input src/elements.ofn \
      --input src/chebi_33250.ofn \
      --output chebi-atomic-numbers.owl

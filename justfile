format:
    npx --yes prettier --check --prose-wrap always --write '**/*.md'

download-chebi:
    if [ ! -f src/chebi.owl ]; then \
        wget \
            https://ftp.ebi.ac.uk/pub/databases/chebi/ontology/chebi.owl \
            -O src/chebi.owl; \
    fi

extract: download-chebi
    if [ ! -f src/chebi-atoms.ofn ]; then \
        ROBOT_JAVA_ARGS="-Djdk.xml.maxGeneralEntitySizeLimit=10000000 -Djdk.xml.totalEntitySizeLimit=10000000" robot extract \
          --prefixes src/prefixes.json \
          --input src/chebi.owl \
          --method MIREOT \
          --branch-from-term CHEBI:33250 \
          --output src/chebi-atoms.ofn; \
    fi

convert: extract
    robot template \
      --prefixes src/prefixes.json \
      --template src/properties.tsv \
      --template src/elements.tsv \
      --template src/isotopes.tsv \
      --output src/tmp.ofn
    robot merge \
      --prefixes src/prefixes.json \
      --input src/metadata.ofn \
      --input src/tmp.ofn \
      --input src/chebi-atoms.ofn \
      query \
      --prefixes src/prefixes.json \
      --update src/isobar-construct.ru \
      --update src/isotone-construct.ru \
      --update src/isotope-construct.ru \
      --output chebi-atomic-numbers.owl

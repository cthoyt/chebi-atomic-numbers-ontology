# /// script
# requires-python = ">=3.14"
# dependencies = [
#     "pandas>=3.0.6",
# ]
# ///

import pandas as pd
from pathlib import Path
HERE = Path(__file__).parent.resolve()


def main() -> None:
    for path in HERE.joinpath("src").glob("*.tsv"):
        df = pd.read_csv(path, sep="\t", dtype=str)
        df.to_csv(path, sep="\t", index=False)


if __name__ == '__main__':
    main()

# phosphateRock

The global dataset on phosphate mining and beneficiation covers worldwide production of phosphate rock (PR) at the level of phosphate mining and beneficiation complex. The objective is to gather complex-specific data on the P content of mined and beneficiated resource and on the recovery rates of beneficiation process. Phosphate mining and beneficiation complex refers to a phosphate ore deposit with adjacent mine(s) and beneficiation plant(s). See [Introduction](vignettes/Introduction.pdf) for details.

The “Global dataset on phosphate mining and beneficiation” is structured into 7 data frames:
1. `mining_complexes` stores the general properties of individual phosphate mining complexes
2. `ore` stores information on the P2O5 grade of ore
3. `PR` stores information on the P2O5 grade of PR
4. `mineral` stores information on the P2O5 grade of mineral
5. `recovery_mass` stores mass recovery rates 
6. `recovery_mineral` stores mineral recovery rates
7. `sources` contains description of data sources, including their identifiers, references to source document(s), data relevance, data quality, and details on the performed data collection

## Installation

```R
# Install the development version from GitHub
devtools::install_github("shchipts/phosphate-rock", subdir = "R/phosphateRock", build_vignettes = TRUE)
```

## License

Copyright © 2024 International Institute for Applied Systems Analysis

Licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0)
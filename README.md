
# MEAanalysis

<!-- badges: start -->
[![codecov](https://codecov.io/gh/ankemt/MEAanalysis/branch/main/graph/badge.svg?token=WTTROZWXQS)](https://codecov.io/gh/ankemt/MEAanalysis) [![R build status](https://github.com/ankemt/MEAanalysis/workflows/R-CMD-check/badge.svg)](https://github.com/ankemt/MEAanalysis/actions)

<!-- badges: end -->

The goal of MEAanalysis is to analyse files from the MEA machine.

## Installation

You can install the development version of MEAanalysis from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ankemt/MEAanalysis")
```

## Getting started

The MEAanalysis package is under active development. Currently, it can be used to create a tidy data object that aggregates data from baseline and exposure neural metrics files that are output files of the MEA device.

### Step 1: create an inputfile with the experimental design

This can be done with the following function:

``` r
MEAanalysis::exp_design()
```

This call prompts a few questions: first, the date of the experiment and the experiment ID. 
For example, the experiment `TestExperiment` done on October 3rd 2020:
``` r
What is the date of the experiment? (YYYYMMDD) 20201003
What is the experiment ID? TestExperiment
```

Then, you can add well ranges for the different experimental conditions.
For example, here is how to add a range of wells for the control:
``` r
What is the experimental condition? control
In what direction ('LR' for left-to-right or 'TB' for top-to-bottom) is the sequence of wells? TB
What is the first well in this category? (e.g.: A1) A1
What is the last well in this category? (e.g.: F8) B2
Do you want to add another group? (y/n) n
```

This generates the file `design.txt` saved in the current working directory, with the following content:
```
Date: 20201003
ExperimentID: TestExperiment
Total_wells: 48
Groups:
control: A1 B1 C1 D1 E1 F1 A2 B2
```
This file can of course also be generated and edited by hand.

### Step 2: Calculate the experiment's treatment ratio

For this function, three input files are required:
- The neural metrics for the baseline (a `.csv` file)
- The neural metrics for the exposure (a `.csv` file)
- The design file created under step 1.

Calculate the treatment ratio as follows:
``` r
data <- MEAanalysis::treatment_ratio(
          exposurepath = "path/to/exposurefile.csv",
          baselinepath = "path/to/baselinefile.csv",
          designpath = "path/to/design.txt")
```

The object created here contains the raw values from both input files (`Baseline_value` and `Exposure_value`) for all wells (included in the `design.txt` file) and parameters, as well as the `Treatment_ratio`, a calculation of exposure/baseline.

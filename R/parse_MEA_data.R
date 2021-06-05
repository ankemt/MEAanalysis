parse_MEA_data <- function(exposurefile, baselinefile){
  exposure <- parse_MEA_file(exposurefile)
  baseline <- readr::read_csv(baselinefile)

  df <- exposure
  return(df)
}

# Helpers
parse_MEA_file <- function(path){
  no_col <- max(count.fields(path, sep = ","))
  file <- read.csv(path,sep=",",fill=TRUE,header = F,col.names=1:no_col)

  # select header info
  header <- extract_header(file)

  # select well info and flip axes *transpose

  return(header)
}


extract_header <- function(file){
  # what row number has "Well Averages"? This is the first data row.
  # extract all data above this row
  n_data <- grep(pattern = "Well Averages", x = dplyr::pull(file, 1))
  header <- file[1:n_data-1,]
  # remove empty columns
  header <- Filter(function(x)!all(x == ""), header)
  # unite all content of last columns to one
  header <- tidyr::unite(header, col = "info", -X1, sep = " ")
  # split first column into two (based on whether there are spaces or not)
  header <- split_based_on_space(header)
  return(header)
}

split_based_on_space <- function(df){
  return(df)
}

test <- parse_MEA_file("~/Projects/MEA/200814_LvM_256062_1293-05_MEA_rCortex_Permethrin_exposure_female_DIV11_Spike Detector (7 x STD)_neuralMetrics.csv")

df <- parse_MEA_data(
  exposurefile = "~/Projects/MEA/200814_LvM_256062_1293-05_MEA_rCortex_Permethrin_exposure_female_DIV11_Spike Detector (7 x STD)_neuralMetrics.csv",
  baselinefile = "~/Projects/MEA/200814_LvM_256062_1293-05_MEA_rCortex_Permethrin_baseline_female_DIV11_Spike Detector (7 x STD)_neuralMetrics.csv")

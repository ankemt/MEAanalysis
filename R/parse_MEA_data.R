parse_MEA_data <- function(exposurefile, baselinefile){
  exposure <- parse_MEA_file(exposurefile)
  baseline <- readr::read_csv(baselinefile)

  df <- exposure
  return(df)
}

# Helpers
parse_MEA_file <- function(path){
  file <- readr::read_csv(path)
  # select header info
  # what row number has "Well averages"? This is the first data row.
  n_data <- grep(pattern = "Well Averages", x = dplyr::pull(file, 1))
  header <- file[1:n_data-1,]
  # select well info and flip axes *transpose

  return(header)
}


parse_MEA_file("~/Projects/MEA/200814_LvM_256062_1293-05_MEA_rCortex_Permethrin_exposure_female_DIV11_Spike Detector (7 x STD)_neuralMetrics.csv")



df <- parse_MEA_data(
  exposurefile = "~/Projects/MEA/200814_LvM_256062_1293-05_MEA_rCortex_Permethrin_exposure_female_DIV11_Spike Detector (7 x STD)_neuralMetrics.csv",
  baselinefile = "~/Projects/MEA/200814_LvM_256062_1293-05_MEA_rCortex_Permethrin_baseline_female_DIV11_Spike Detector (7 x STD)_neuralMetrics.csv")

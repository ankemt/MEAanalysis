library(MEAanalysis)

# load files
test_baseline <- parse_MEA_file("inst/extdata/baseline_testfile.csv")
test_exposure <- parse_MEA_file("inst/extdata/exposure_testfile.csv")

WA_test_baseline <-test_baseline$`Well averages`
WA_test_exposure <- test_baseline$`Well averages`

# add baseline to each parameter of baseline
renamed_baseline <- colnames(WA_test_baseline) %>%
  paste("baseline", colnames(WA_test_baseline), sep = "_")

# add exposure to each parameter of exposure
# merge to files
# calculate treatment ratio


# calculate treatment ratios well Averages
# (Parameter exposure / Parameter Baseline) *100%

#' Calculate the treatment ratio between exposure and baseline of MEA output files
#' (Currently incomplete)
#'
#' @param exposurepath Path to file with exposure data
#' @param baselinepath Path to file with baseline data
#' @param treatmentpath Path to file with treatment lay-out
#' @return file with [1] treatment ratio per parameter per well
#' @export
treatment_ratio <- function(exposurepath, baselinepath, treatment){
  exposure <- parse_MEA_file(exposurepath)
  baseline <- parse_MEA_file(baselinepath)

  # TODO calculate differences
  # TODO parse treatment information
  return(exposure)
}

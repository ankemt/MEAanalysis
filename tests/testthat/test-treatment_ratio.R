test_that("treatment ratio file contains expected parameters", {

  exposurepath <- "inst/extdata/exposure_testfile.csv"
  baselinepath <- "inst/extdata/baseline_testfile.csv"
  treatmentpath <- ""
  resultfile = treatment_ratio(
                  exposurepath = exposurepath,
                  baselinepath = baselinepath,
                  treatmentpath = treatmentpath
                  )

  result = open(resultfile)
  param_column = result[1,]

  known_params = c("Number of Spikes",
                   "Number of Bursts",
                   "Mean ISI within Burst - Avg (sec)")

  for(param in known_params){
    testthat::expect_true(param%in%param_column)
  }
})

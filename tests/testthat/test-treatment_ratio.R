test_that("treatment ratio file contains expected parameters", {

  baseline_source <- system.file("extdata", "baseline_testfile.csv", package = "MEAanalysis")
  exposure_source <- system.file("extdata", "exposure_testfile.csv", package = "MEAanalysis")
  design_source <- system.file("extdata", "design_testfile.txt", package = "MEAanalysis")

  result <- treatment_ratio(
                  exposurepath = exposure_source,
                  baselinepath = baseline_source,
                  designpath = design_source)

  known_params = c("Number of Spikes",
                   "Number of Bursts",
                   "Mean ISI within Burst - Avg (sec)")

  for(param in known_params){
    testthat::expect_true(param%in%result$Parameter)
  }

  # if the headers don't match, an error is produced
  exposure_source_2 <- system.file("extdata", "exposure_testfile_2.csv", package = "MEAanalysis")
  expect_error(
    result <- treatment_ratio(
      exposurepath = exposure_source_2,
      baselinepath = baseline_source,
      designpath = design_source),
    regexp = "The MEA files provided have different metadata attributes"
  )

})

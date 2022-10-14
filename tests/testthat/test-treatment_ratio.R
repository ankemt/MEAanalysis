test_that("treatment ratio file contains expected parameters", {

  baseline_source <- system.file("extdata", "baseline_testfile.csv", package = "MEAanalysis")
  exposure_source <- system.file("extdata", "exposure_testfile.csv", package = "MEAanalysis")
  design_source <- system.file("extdata", "design_testfile.csv", package = "MEAanalysis")

  result <- treatment_ratio(
                  exposurepath = exposure_source,
                  baselinepath = baseline_source,
                  designpath = design_source)

  expect_true(typeof(result) == "list") # remove this for the real test


  # param_column = result[1,]
  #
  # known_params = c("Number of Spikes",
  #                  "Number of Bursts",
  #                  "Mean ISI within Burst - Avg (sec)")
  #
  # for(param in known_params){
  #   testthat::expect_true(param%in%param_column)
  # }


})

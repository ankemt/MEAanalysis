test_that("MEA file is correctly parsed", {
  baseline_source <- system.file("extdata", "baseline_testfile.csv", package = "MEAanalysis")
  baseline_parsed <- parse_MEA_file(baseline_source)
  #exposure_source <- system.file("extdata", "exposure_testfile.csv", package = "MEAanalysis")
  #exposure_parsed <- parse_MEA_file(exposure_source)
  # check if list is created
  expect_type(baseline_parsed, "list")
  #expect_type(exposure_parsed, "list")

  # does list contain 3 elements (header, well averages, electrodes)
  #expect_equal(names(baseline_parsed), c("Header", "Well averages", "Electrodes"))
  # does the header have right dimensions?
  # do well averages have right dimensions?
  # do electrodes have right dimensions?
  # check that there is an ID column
  # check that everything else is numeric data
  # check that there are no NA columns
  # check that header contains setting and subsetting
  # check that header setting is filled and does not contain NAs, subsetting may contain NAs
  # check that header setting contains 9 levels
  # check that header subsetting contains 9 levels
  # check that all three columns of header are character
  # check that well averages are numeric and do not contain NAs
  # check that baseline electrodes contains 317 NAs
  # check that exposure electrodes contains 446 NAs

  })


test_that("MEA file is correctly parsed", {
  baseline_source <- system.file("extdata", "baseline_testfile.csv", package = "MEAanalysis")
  baseline_parsed <- parse_MEA_file(baseline_source)

  # check if list is created
  expect_type(baseline_parsed, "list")

  # does list contain 3 elements (header, well averages, electrodes)
  expect_equal(names(baseline_parsed), c("Header", "Well averages", "Electrodes"))

  # one of the objects is "Well Averages", another "Electrodes"
  expect_true("Well averages" %in% names(baseline_parsed))
  expect_true("Electrodes" %in% names(baseline_parsed))

  # Assigns names to each df in list and seperate them so that they can be inspected
  HD <- baseline_parsed$Header
  WA <- baseline_parsed$`Well averages`
  EL <- baseline_parsed$Electrodes

  # do header, well averages and electrodes have right dimensions?
  expect_equal(dim(HD), c(15, 3))
  expect_equal(dim(WA), c(48, 49))
  expect_equal(dim(EL), c(768, 20))

  # check that header contains setting and subsetting
  expect_equal(names(HD), c("Setting", "Sub-setting", "Value"))

  # check that header setting is filled and does not contain NAs
  expect_true(sum(is.na(HD$Setting)) == 0)

  # check that header setting contains 9 levels
  expect_equal(nlevels(as.factor(HD$Setting)), 9)

  # check that header subsetting contains 9 levels
  expect_equal(nlevels(as.factor(HD$`Sub-setting`)), 9)

  # check that first column of header is character
  expect_true(is.character(HD$Setting))

  # check that well averages are numeric and do not contain NAs
  expect_true(sum(is.na(WA)) == 0)
  expect_true(is.numeric(WA$`Activity Metrics: Number of Spikes`))

  # check that baseline electrodes are numeric and contain 317 NAs
  expect_true(sum(is.na(EL)) == 317)
  expect_true(is.numeric(EL$`Activity Metrics: Number of Spikes`))

})


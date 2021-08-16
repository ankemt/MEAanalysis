test_that("a list is generated", {
  testsource <- system.file("extdata", "baseline_testfile.csv", package = "MEAanalysis")
  testfile <- parse_MEA_file(testsource)
  expect_type(testfile, "list")
})

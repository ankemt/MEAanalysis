test_that("MEA files are matched on their header data", {
  baseline_source <- system.file("extdata", "baseline_testfile.csv", package = "MEAanalysis")
  exposure_source <- system.file("extdata", "exposure_testfile.csv", package = "MEAanalysis")

  bas <- parse_MEA_file(baseline_source)
  exp <- parse_MEA_file(exposure_source)

  bas_H <- bas$Header
  exp_H <- exp$Header

  expect_true(match_MEA_files(bas_H, exp_H))

  # Edit header so they no longer match
  exp_H$Value <- paste(exp_H$Value, "add")

  expect_false(match_MEA_files(bas_H, exp_H))

})

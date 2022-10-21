test_that("MEA files are matched on their header data", {
  baseline_source <- system.file("extdata", "baseline_testfile.csv", package = "MEAanalysis")
  exposure_source <- system.file("extdata", "exposure_testfile.csv", package = "MEAanalysis")

  bas <- parse_MEA_file(baseline_source)
  exp <- parse_MEA_file(exposure_source)

  bas_H <- bas$Header
  exp_H <- exp$Header

  expect_no_error(match_MEA_files(bas_H, exp_H))

  # Edit header so they no longer match
  exp_H$Value <- paste(exp_H$Value, "add")

  expect_error(match_MEA_files(bas_H, exp_H),
               regexp = "The MEA files provided have different metadata attributes")


})


test_that("MEA files and header metadata match", {
  exposure_source <- system.file("extdata", "exposure_testfile.csv", package = "MEAanalysis")
  exp <- parse_MEA_file(exposure_source)

  design_source <- system.file("extdata", "design_testfile.txt", package = "MEAanalysis")
  design <- parse_designfile(design_source)

  expect_no_error(match_MEA_design(design$metadata, exp))

  # header that should throw an error
  design_high <- data.frame(Date = "20220905",
             ExperimentID = "test",
             Total_wells = "50")
  expect_warning(match_MEA_design(design_high, exp),
                 regexp = "Not all wells in the design file have corresponding data")

  design_low <- data.frame(Date = "20220905",
                            ExperimentID = "test",
                            Total_wells = "40")
  expect_error(match_MEA_design(design_low, exp),
                 regexp = "The design file has fewer wells than the MEA file")

})

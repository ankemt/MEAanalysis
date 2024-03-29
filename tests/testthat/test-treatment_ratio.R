test_that("treatment ratio file contains expected parameters", {

  baseline_source <- system.file("extdata", "baseline_testfile.csv", package = "MEAanalysis")
  exposure_source <- system.file("extdata", "exposure_testfile.csv", package = "MEAanalysis")
  design_source <- system.file("extdata", "design_testfile.txt", package = "MEAanalysis")

  # TODO expect metadata to be returned to the command line
  result <- treatment_ratio(
                  exposurepath = exposure_source,
                  baselinepath = baseline_source,
                  designpath = design_source)

  known_params = c("Number of Spikes",
                   "Number of Bursts",
                   "Mean ISI within Burst - Avg (sec)")

  for(param in known_params){
    expect_true(param%in%result$Parameter)
  }

  # confirm the full output with a snapshot
  expect_snapshot(result)
})

test_that("file is saved correctly and not overwritten", {
  baseline_source <- system.file("extdata", "baseline_testfile.csv", package = "MEAanalysis")
  exposure_source <- system.file("extdata", "exposure_testfile.csv", package = "MEAanalysis")
  design_source <- system.file("extdata", "design_testfile.txt", package = "MEAanalysis")

  # run the function to create the csv file
  folder <- "treatment-ratio-output"
  dir.create(folder)

  expect_warning(
    treatment_ratio(
      exposurepath = exposure_source,
      baselinepath = baseline_source,
      designpath = design_source,
      save = T,
      path = folder),
    regexp = "The resulting data  has been saved")

  # expect the file
  fname <- paste0(folder, "/test_20220905_treatment-ratio_",Sys.Date(),".csv")
  expect_true(file.exists(fname))

  expect_error(
    treatment_ratio(
      exposurepath = exposure_source,
      baselinepath = baseline_source,
      designpath = design_source,
      save = T,
      path = folder),
    regexp = "The result was not saved.")

  # remove the folder + file
  unlink(folder, recursive = T)

  # just to make sure that the delete went well
  expect_false(dir.exists(folder))
})

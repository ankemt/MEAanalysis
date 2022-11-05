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
  # TODO expect metadata to be returned to the command line
  treatment_ratio(
    exposurepath = exposure_source,
    baselinepath = baseline_source,
    designpath = design_source,
    save = T)

  # expect the file
  fname <- "test_20220905.csv"
  expect_true(file.exists(fname))

  expect_error(
    treatment_ratio(
      exposurepath = exposure_source,
      baselinepath = baseline_source,
      designpath = design_source,
      save = T),
    regexp = "The result was not saved.")

  # remove the file
  file.remove(fname)

})

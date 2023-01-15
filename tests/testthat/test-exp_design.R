test_that("Design file is created correctly", {
  tempdir = "temp-test-exp_design"
  dir.create(tempdir)
  date <- "20220109"
  expID <- "test"
  exp_design(date = date, expID = expID, dir = tempdir)
  designfile <- paste0(tempdir, "/design.txt")
  expect_true(file.exists(designfile))

  design <- readLines(designfile)
  expected_content <- paste0("Date: ", date)
  expect_true(expected_content %in% design)

  expected_content <- paste0("ExperimentID: ", expID)
  expect_true(expected_content %in% design)

  unlink(tempdir, recursive = T)
})

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


test_that("Wells are categorized correctly", {
  expect_error(categorize_wells(start = "A1", end = "A5", direction = "not valid"),
               regexp = "The direction must be")

  expect_error(categorize_wells(start = "A1", end = "A5", nwells = "not valid"),
               regexp = "should be a number")

  expect_error(categorize_wells(start = "A1", end = "A5", nwells = 13),
               regexp = "total number of wells")

  wells <- categorize_wells(start = "A1", end = "A5")
  expect_equal(wells, "A1 A2 A3 A4 A5")

  wells <- categorize_wells(start = "A1", end = "E1", direction = "TB")
  expect_equal(wells, "A1 B1 C1 D1 E1")


})

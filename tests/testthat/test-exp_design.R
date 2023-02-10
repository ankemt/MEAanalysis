tempdir = "temp-test-exp_design"
dir.create(tempdir)
designfile <- paste0(tempdir, "/design.txt")

test_that("Design file is created correctly", {
  write_meta(date = "20220109", expID = "test", nwells = 48, path=designfile)

  expect_true(file.exists(designfile))

  design <- readLines(designfile)
  expect_true("Date: 20220109" %in% design)
  expect_true("ExperimentID: test" %in% design)
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

  wells <- categorize_wells(start = "A1", end = "B1")
  expect_equal(wells, "A1 A2 A3 A4 A5 A6 A7 A8 B1")

  wells <- categorize_wells(start = "C4", end = "D2")
  expect_equal(wells, "C4 C5 C6 C7 C8 D1 D2")

  wells <- categorize_wells(start = "A1", end = "E1", direction = "TB")
  expect_equal(wells, "A1 B1 C1 D1 E1")

  wells <- categorize_wells(start = "A1", end = "B1", direction = "TB")
  expect_equal(wells, "A1 B1")

  wells <- categorize_wells(start = "C5", end = "A6", direction = "TB")
  expect_equal(wells, "C5 D5 E5 F5 A6")
})


testthat::test_that("Categories are written correctly",{
  write_category(
    group = "0.1",
    start = "A1",
    end = "A4",
    dirx = "LR",
    nwells = 48,
    path = designfile
  )

  design <- readLines(designfile)
  expect_true("0.1: A1 A2 A3 A4" %in% design)
})

unlink(tempdir, recursive = T)

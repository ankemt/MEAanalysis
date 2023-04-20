test_that("designfile is correctly parsed", {
  design_source <- system.file("extdata", "design_testfile.txt", package = "MEAanalysis")
  design_output <- parse_designfile(design_source)

  # the outcome of this function is a list
  expect_type(design_output, "list")

  # does list contain 2 elements (metadata, design)
  expect_equal(names(design_output), c("metadata", "design"))

  # does metadata contain 3 elements ("Date", "ExperimentID", "Total_wells")
  expect_equal(names(design_output$metadata), c("Date", "ExperimentID", "Total_wells"))

  # does metadata contain 1 row
  expect_equal(nrow(design_output$metadata), 1)

  # does design dataframe contain the right dimensions
  expect_equal(dim(design_output$design), c(48, 2))

  # does design contain two columns: well and group
  expect_equal(names(design_output$design), c("Well", "Group"))
})

test_that("duplicates are detected", {
  design_source <- system.file("extdata", "design_testfile_duplicates.txt", package = "MEAanalysis")
  expect_error(parse_designfile(design_source), regexp="Duplicate")
})

test_that("unequal rows are accepted", {
  design_source <- system.file("extdata", "design_testfile_unequalrows.txt", package = "MEAanalysis")
  design_output <- parse_designfile(design_source)
  expect_equal(dim(design_output$design), c(15, 2))
})

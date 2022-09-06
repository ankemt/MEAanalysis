test_that("designfile is correctly parsed", {
  design_source <- system.file("extdata", "baseline_testfile.csv", package = "MEAanalysis")
  design <- parse_designfile(design_source)

  # the outcome of this function is a list
  expect_type(design, "list")

  # does list contain 2 elements (metadata, design)
  expect_equal(names(design), c("metadata", "design"))
})

test_that("Summary is calculated correctly",{
  load("output_treatment_ratio.Rda")

  statsum <- treatment_stats(output_treatment_ratio)
  expect_true("tbl_df" %in% class(statsum))
  expect_equal(nrow(statsum), 288)
  expect_equal(ncol(statsum), 5)
})

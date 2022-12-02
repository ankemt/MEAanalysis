test_that("Summary is calculated correctly",{
  load("output_treatment_ratio.Rda")

  statsum <- treatment_stats(output_treatment_ratio)
  expect_true("tbl_df" %in% class(statsum))
  expect_equal(nrow(statsum), 288)

  expected_cols <- c("Ratio_avg",
                     "Ratio_stdv",
                     "Ratio_SEM",
                     "n_wells",
                     "Group",
                     "Metric_type",
                     "Parameter")
  for(cname in expected_cols){
    expect_true(cname %in% names(statsum),
                info=paste("Variable:",cname))
  }

  # there are 8 wells per group in the example data
  expect_true(mean(statsum$n_wells) == 8)

  # check some values
  vals <- statsum[statsum$Parameter == "Mean Firing Rate (Hz)",]$Ratio_SEM
  vals <- round(vals, digits = 8)
  known_vals <- c(0.15674431,
                  0.04957502,
                  0.09320916,
                  0.12364473,
                  0.28510038,
                  0.12974997)
  expect_true(all(known_vals %in% vals))

})

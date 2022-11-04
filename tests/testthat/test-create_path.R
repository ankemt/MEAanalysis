test_that("file path parsed correctly", {
  resultpath <- "this/is/my/path"

  testpath <- create_path("this/is/my/path")
  expect_equal(testpath, resultpath)

  testpath <- create_path("this\\is\\my\\path")
  expect_equal(testpath, resultpath)
  })


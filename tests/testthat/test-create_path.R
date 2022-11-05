test_that("folder path parsed correctly", {
  # TODO this test will only work on unix because of separators.
  # How do we fix this for windows?

  resultpath <- "this/is/my/path"

  testpath <- create_path("this/is/my/path")
  expect_equal(testpath, resultpath)

  testpath <- create_path("this\\is\\my\\path")
  expect_equal(testpath, resultpath)

  testpath <- create_path("this/is/my/path/")
  expect_equal(testpath, resultpath)

  rootpath <- "/this/is/my/path"
  testpath <- create_path("/this/is/my/path/")
  expect_equal(testpath, rootpath)

  winpath <- "C://dir/subdir"
  testpath <- create_path("C://dir/subdir")
  expect_equal(testpath, winpath)
  })


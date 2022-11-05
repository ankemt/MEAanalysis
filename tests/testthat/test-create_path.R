test_that("folder path parsed correctly", {
  # These tests currently work on all platforms (macOSX, ubuntu, windows; 20221105).
  # However, the function create_path uses a platform-dependent separator,
  # created with .Platform$file.sep
  # This is a / on all platforms, apparently; otherwise tests would fail.
  resultpath <- "this/is/my/path"
  winpath <- "C://dir/subdir"
  rootpath <- "/this/is/my/path"

  testpath <- create_path("this/is/my/path")
  expect_equal(testpath, resultpath)

  testpath <- create_path("this\\is\\my\\path")
  expect_equal(testpath, resultpath)

  testpath <- create_path("this/is/my/path/")
  expect_equal(testpath, resultpath)

  testpath <- create_path("/this/is/my/path/")
  expect_equal(testpath, rootpath)

  testpath <- create_path("C://dir/subdir")
  expect_equal(testpath, winpath)
  })


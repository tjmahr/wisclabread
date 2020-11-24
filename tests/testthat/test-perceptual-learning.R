paths_pl <- list.files(
  testthat::test_path("data"),
  "perceptual_learning",
  full.names = TRUE
)

test_that("can read in wtocs in perceptual learning files", {
  results <- read_wtocs_in_perceptual_learning(paths_pl[1])
  expect_equal(nrow(results), 37)

  results <- read_wtocs_in_perceptual_learning(paths_pl[2])
  expect_equal(nrow(results), 37)
})

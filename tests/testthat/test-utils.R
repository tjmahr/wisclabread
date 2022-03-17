x <- c(
  "XXv17_SLOW_s4T06.TextGrid",
  "XXv14_SLOW_s5T04.TextGrid",
  "XXv16s6T06.TextGrid",
  "XX(b)v16s7T03.TextGrid",
  "XXv15_SLOW_s2T01.TextGrid",
  "XXv18wT11.wav",
  "XXv16s7T06.lab",
  "XXv15s5T06.lab",
  "XXv13s3T10.WAV",
  "XXv16S2T09.wav"
)

expected <- c(
  "S4T06",
  "S5T04",
  "S6T06",
  "S7T03",
  "S2T01",
  "WT11",
  "S7T06",
  "S5T06",
  "S3T10",
  "S2T09"
)
expected_lengths <- c(4, 5, 6, 7, 2, 1, 7, 5, 3, 2)

test_that("tocs_item() works", {
  expect_equal(tocs_item(x), expected)
})

test_that("is_tocs_item() works", {
  # fails on files, works on expected tocs_item() outputs
  expect_false(any(is_tocs_item(x)))
  expect_true(all(is_tocs_item(expected)))

  expect_false(is_tocs_item("S0T01"))
  expect_false(is_tocs_item("S8T01"))
  expect_false(is_tocs_item("ST01"))
  expect_false(is_tocs_item("W1T01"))
  expect_false(is_tocs_item("S2T1"))
  expect_false(is_tocs_item("S2T001"))
  # there are no 1-word S items
  expect_false(is_tocs_item("S1T01"))

  expect_true(is_tocs_item("WT01"))
  expect_true(is_tocs_item("S2T01"))
})

test_that("tocs_length() works", {
  x |>
    tocs_length() |>
    expect_equal(expected_lengths)

  expected |>
    tocs_length() |>
    expect_equal(expected_lengths)

  c("Something", "Weird", "S1T01", "W01", NA) |>
    tocs_length() |>
    expect_equal(c(NA_real_, NA_real_, NA_real_, NA_real_, NA_real_))
})

test_that("tocs_type() works", {
  # first two have the correct first character but not the pattern
  c("Something", "Weird", "S1T01", "W01", NA) |>
    tocs_type() |>
    expect_equal(rep(NA, 5))

  c("S2T01", "WT01") |>
    tocs_type() |>
    expect_equal(c("multiword", "single-word"))
})


#' Extract TOCS item ID from a TOCS-related file
#' @param xs a character vector of filenames (`.wav`, `.TextGrid`, `.lab` files
#'   are supported) or a character vector of TOCS item IDs
#' @return `tocs_item()` returns the item ID, `is_tocs_item()` returns `TRUE` or
#'   `FALSE`, `tocs_length()` returns the length of item (1 to 7 words),
#'   `tocs_type()` returns `"single-word"` for 1-word `"WT"` items and
#'   `"multiword"` for `"S"` items with a length greater than 1.
#' @export
#' @rdname tocs_item
#' @examples
#' x <- c(
#'   "XXv17_SLOW_s4T06.TextGrid",
#'   "XXv14_SLOW_s5T04.TextGrid",
#'   "XXv16s6T06.TextGrid",
#'   "XX(b)v16s7T03.TextGrid",
#'   "XXv15_SLOW_s2T01.TextGrid",
#'   "XXv18wT11.wav",
#'   "XXv16s7T06.lab",
#'   "XXv15s5T06.lab",
#'   "XXv13s3T10.WAV",
#'   "XXv16S2T09.wav",
#'   # note that these are bad
#'   "XXv1_W09.wav",  # no "T"
#'   "XXv1_S109.wav", # no "T"
#'   "XXv1_S1T09.wav" # no 1-word S items
#' )
#'
#' tocs_item(x)
#' is_tocs_item(tocs_item(x))
#' tocs_length(x)
#' tocs_type(x)
tocs_item <- function(xs) {
  ifelse(
    is_tocs_item(xs),
    xs,
    xs |>
      toupper() |>
      stringr::str_extract("(S[2-7]|W)(T)\\d\\d(?=.?[.](WAV|TEXTGRID|LAB))")
  )
}

#' @export
#' @rdname tocs_item
is_tocs_item <- function(xs) {
  detected <- xs |>
    stringr::str_detect("^(W|S[2-7])T\\d{2}$")
  detected[is.na(detected)] <- FALSE
  detected
}

#' @export
#' @rdname tocs_item
tocs_length <- function(xs) {
  items <- tocs_item(xs)
  first_char <- substr(items, 1, 1)
  second_char <- substr(items, 2, 2)
  lengths <- rep(NA_character_, length(items))

  lengths <- ifelse(first_char == "W", "1", lengths)
  lengths <- ifelse(first_char == "S", second_char, lengths)
  as.numeric(lengths)
}


#' @export
#' @rdname tocs_item
tocs_type <- function(xs) {
  lengths <- tocs_length(xs)
  types <- rep(NA_character_, length(lengths))
  types <- ifelse(lengths == 1, "single-word", types)
  ifelse(lengths > 1, "multiword", types)
}


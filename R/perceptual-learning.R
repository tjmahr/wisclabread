#' Read in the WTOCS lines from a perceptual learning file
#'
#' @param path path to a perceptual learning file. It should have the standard
#'   file naming convention.
#' @return a dataframe (tibble) of the tab-separated data in the file that has
#'   the columns `Word`, `Response`, `Correct`, and end with `Articulation`.
#' @export
read_wtocs_in_perceptual_learning <- function(path) {
  # Require the word "perceptual" plus any number of letters, numbers, hyphens,
  # or underscores followed by ".txt"
  stopifnot(stringr::str_detect(path, "perceptual[\\w-_]*.txt"))

  lines <- readLines(path)

  # Extract the number of WTOCs items. We can use it to check our work.
  wtocs_count_line <- stringr::str_subset(lines, "wtocs count")
  # "\\d": digit, "+": any number of, "$": end of string
  # "\\d+$": any number of digits at the end of the string
  wtocs_count <- as.numeric(stringr::str_extract(wtocs_count_line, "\\d+$"))

  # First we need to find the lines that contain the data. This is the kind of
  # job that might happen with other kinds of data or files, so we put that work
  # into its own generic function (defined below).
  wtocs_line_numbers <- find_file_subsection(
    lines,
    pattern_start <- "Word\tResponse\tCorrect.*\tArticulation",
    pattern_end <- "Word\tResponse\tCorrect.*"
  )

  data <- readr::read_tsv(lines[wtocs_line_numbers])
  data <- janitor::clean_names(data)

  stopifnot(nrow(data) == wtocs_count)

  # Add the filename as the first column
  tibble::add_column(
    data,
    .file = basename(path),
    .before = 1
  )

}


find_file_subsection <- function(xs, pattern_start, pattern_end) {
  # Given a text file like:
  #
  #   blah
  #   ...
  #   blah
  #   Imporant section heading
  #   good data
  #   ...
  #   good data
  #   [next section heading or end of file]
  #
  # We want to extract the "Important section heading" and the "good data" lines
  # that follow.

  # Add a blank line so that the end of the file is not data.
  xs <- c(xs, "\n")

  # Find where the section starts. There should only be one matching line.
  line_start <- stringr::str_which(xs, pattern = pattern_start)
  stopifnot(length(line_start) == 1)

  # We need to find where the section ends: either the next section heading or
  # the end of the file.
  line_possible_ends <- c(
    stringr::str_which(xs, pattern = pattern_end),
    # End of file.
    length(xs)
  )

  # The end of the good data will be the first possible ending line after the
  # starting line. We subtract 1 because these lines are the start of the
  # section. The last line of good data will be the line before that section.
  line_end <- min(line_possible_ends[line_start < line_possible_ends]) - 1

  stopifnot(length(line_end) == 1)
  stopifnot(line_start <= line_end)

  seq(line_start, line_end, by = 1)
}

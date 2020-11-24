str_parse_wisclab_filename <- function(xs) {
  matches <- stringr::str_match(
    basename(xs),
    "(.+)(v\\d\\d)(.+)(\\d{10})(.*)"
  )
  matches <- as.list(matches)

  names(matches) <- c(
    "string", "child", "visit", "type", "control_file_num", "rest"
  )
  matches
}

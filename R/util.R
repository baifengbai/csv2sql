#' @keywords internal
ifelse_FUN <- function(check, f1, f2) {
  if (check) return(f1)
  f2
}

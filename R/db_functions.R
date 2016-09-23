#' Get number of rows of a database object
#' @param A tbl object connected to a database.
#' @export
db_nrow <- function(db_df0) {
  db_df0 %>%
    summarise(n()) %>%
    as.data.frame() %>%
    as.numeric()
}

#' A function to convert csv file to sql file (using 'sqldf' package).
#' @param csv_name Character string; path of the file.
#' @param db_name Character string; path of the database.
#' @param table_name Characeter string; (desired) table name.
#' @export
csv_to_sql <- function(csv_name, db_name, table_name) {
  if (missing(table_name)) table_name <- "main"
  # Create SQL DB
  db_name %>%
    paste("attach", ., "as new", sep = " ") %>%
    sqldf::sqldf()
  # read and save csv to SQL
  table_name %>%
    paste("create table", ., "as select * from file", sep = " ") %>%
    sqldf::read.csv.sql(file = csv_name, sql = ., dbname = db_name)
}


#' A function to convert csv file to sqlite3 file (using 'dplyr' package).
#' @param csv_name Character string; path of the file.
#' @param db_name Character string; path of the database.
#' @param table_name Characeter string; (desired) table name.
#' @export
csv_to_sqlite <- function(csv_name, db_name, table_name) {
  if (missing(table_name)) table_name <- "df0"
  my_db <- dplyr::src_sqlite(db_name, create = TRUE)
  df0 <- readr::read_csv(csv_name)
  dplyr::copy_to(my_db, df0, temporary= FALSE)
}


#' A function to convert csv file to sqlite3 file with chunking (using 'dplyr' package).
#' @param csv_name Character string; path of the file.
#' @param db_name Character string; path of the database.
#' @param table_name Characeter string; (desired) table name.
#' @param chunk_size Integer; the number of rows to include in each chunk.
#' @export
csv_to_sqlite_chunked <- function(csv_name, db_name, table_name,
                                  chunk_size = 10000) {
  if (missing(table_name)) table_name <- "df0"
  write_to_db <- function(df0, pos) {
    dplyr::db_insert_into(con = my_db$con, table = table_name, values = df0)
  }

  my_db <- dplyr::src_sqlite(db_name, create = TRUE)
  readr::read_csv_chunked(file = csv_name,
                   callback = readr::SideEffectChunkCallback$new(write_to_db),
                   chunk_size = chunk_size)
}

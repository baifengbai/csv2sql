# csv2sql
R package: A wrapper to convert csv files to sql database

```
# Installation
devtools::install_github("kcf-jackson/csv2sql")

# Example
write.csv(iris, file = "iris.csv")

library(csv2sql)
csv_to_sqlite(csv_name = "iris.csv", db_name = "iris.sqlite3", table_name = "main")
# Note that the row names will automatically be assigned a colunm name.
```

A quickstart guide for 'csv2sql'
================

### Read CSV. Convert to SQL. Subsample.

#### 1. Install and load library

``` r
# devtools::install_github("kcf-jackson/csv2sql")
library(csv2sql)  
library(dplyr)
```

#### 2. Create sample csv file and convert it to sqlite file

``` r
write.csv(iris, file = "iris.csv")  
csv_to_sqlite("iris.csv", "iris.sqlite3", "main")
```

    ## Warning: Missing column names filled in: 'X1' [1]

    ## Parsed with column specification:
    ## cols(
    ##   X1 = col_integer(),
    ##   Sepal.Length = col_double(),
    ##   Sepal.Width = col_double(),
    ##   Petal.Length = col_double(),
    ##   Petal.Width = col_double(),
    ##   Species = col_character()
    ## )

    ## Source:   query [?? x 6]
    ## Database: sqlite 3.8.6 [iris.sqlite3]
    ## 
    ##       X1 Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ##    <int>        <dbl>       <dbl>        <dbl>       <dbl>   <chr>
    ## 1      1          5.1         3.5          1.4         0.2  setosa
    ## 2      2          4.9         3.0          1.4         0.2  setosa
    ## 3      3          4.7         3.2          1.3         0.2  setosa
    ## 4      4          4.6         3.1          1.5         0.2  setosa
    ## 5      5          5.0         3.6          1.4         0.2  setosa
    ## 6      6          5.4         3.9          1.7         0.4  setosa
    ## 7      7          4.6         3.4          1.4         0.3  setosa
    ## 8      8          5.0         3.4          1.5         0.2  setosa
    ## 9      9          4.4         2.9          1.4         0.2  setosa
    ## 10    10          4.9         3.1          1.5         0.1  setosa
    ## # ... with more rows

#### 3. Connect to database and subsample

``` r
my_db <- src_sqlite("iris.sqlite3")
my_tbl <- tbl(my_db, "main")

folds <- caret::createFolds(y = seq(db_nrow(my_tbl)), k = 10)
my_tbl %>% filter(X1 %in% folds[[1]])
```

    ## Source:   query [?? x 6]
    ## Database: sqlite 3.8.6 [iris.sqlite3]
    ## 
    ##       X1 Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
    ##    <int>        <dbl>       <dbl>        <dbl>       <dbl>      <chr>
    ## 1      7          4.6         3.4          1.4         0.3     setosa
    ## 2     13          4.8         3.0          1.4         0.1     setosa
    ## 3     24          5.1         3.3          1.7         0.5     setosa
    ## 4     34          5.5         4.2          1.4         0.2     setosa
    ## 5     49          5.3         3.7          1.5         0.2     setosa
    ## 6     50          5.0         3.3          1.4         0.2     setosa
    ## 7     53          6.9         3.1          4.9         1.5 versicolor
    ## 8     62          5.9         3.0          4.2         1.5 versicolor
    ## 9     77          6.8         2.8          4.8         1.4 versicolor
    ## 10    84          6.0         2.7          5.1         1.6 versicolor
    ## # ... with more rows

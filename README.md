
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wisclabread 🍞

<!-- badges: start -->
<!-- badges: end -->

The goal of wisclabread is to centralize the WiscLab’s functions for
reading and parsing data files.

## Installation

You can install the development version of wisclabread from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("tjmahr/wisclabread")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(wisclabread)
test_perceptual_learning <- file.path(
  "./tests/testthat/data", 
  "/0110_F_AAv01_perceptual_learning-0101010101.txt"
)

read_wtocs_in_perceptual_learning(test_perceptual_learning)
#> # A tibble: 37 x 12
#>    .file word  response correct   tpc s_vwl m_vwl m_vwl_a s_con m_con m_con_a
#>    <chr> <chr> <chr>    <lgl>   <dbl> <dbl> <dbl>   <dbl> <dbl> <dbl>   <dbl>
#>  1 0110~ Boy   boy      TRUE     1        1     1       1     1     1       1
#>  2 0110~ Pan   plant    FALSE    1        1     1       1     2     2       2
#>  3 0110~ Big   faith    FALSE    0        1     0       0     2     0       0
#>  4 0110~ Ball  bay      FALSE    0.33     1     0       0     2     1       1
#>  5 0110~ House axe      FALSE    0.33     1     0       0     2     1       1
#>  6 0110~ Eat   eat      TRUE     1        1     1       1     1     1       1
#>  7 0110~ Toys  dress    FALSE    0        1     0       0     2     0       0
#>  8 0110~ No    know     TRUE     1        1     1       1     1     1       1
#>  9 0110~ Buddy ready    FALSE    0.25     2     0       0     2     1       1
#> 10 0110~ Bus   bus      TRUE     1        1     1       1     2     2       2
#> # ... with 27 more rows, and 1 more variable: articulation <dbl>
```

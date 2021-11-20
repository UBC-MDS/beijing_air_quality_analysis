Exploratory data analysis of Beijing air quality data set
================

# Summary of the data set

## Data Import

    ## # A tibble: 6 × 18
    ##      No  year month   day  hour PM2.5  PM10   SO2   NO2    CO    O3  TEMP  PRES
    ##   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    ## 1     1  2013     3     1     0     4     4     4     7   300    77  -0.7 1023 
    ## 2     2  2013     3     1     1     8     8     4     7   300    77  -1.1 1023.
    ## 3     3  2013     3     1     2     7     7     5    10   300    73  -1.1 1024.
    ## 4     4  2013     3     1     3     6     6    11    11   300    72  -1.4 1024.
    ## 5     5  2013     3     1     4     3     3    12    12   300    72  -2   1025.
    ## 6     6  2013     3     1     5     5     5    18    18   400    66  -2.2 1026.
    ## # … with 5 more variables: DEWP <dbl>, RAIN <dbl>, wd <chr>, WSPM <dbl>,
    ## #   station <chr>

The data set used in this project is an hourly air pollutants data from
12 nationally-controlled air-quality monitoring sites in Beijing, China
from 1 March 2013 to 28 February 2017. The air-quality data is from the
Beijing Municipal Environmental Monitoring Center. It was sourced from
the UCI Machine Learning Repository
[here](https://archive-beta.ics.uci.edu/ml/datasets/beijing+multi+site+air+quality+data).

Each row in the data set represents a measurements of air pollutants
(e.g., PM2.5, PM10, CO) at specific date and time in 12 different
district in Beijing, including Aotizhongxin, Changping, Dingling and so
on. The meteorological data in each air-quality site are matched with
the nearest weather station from the China Meteorological
Administration. There are `420,768` observations in the data set, and
`18` features. Below we show the structure of each features in the data
set.

## Study the data

    ## spec_tbl_df [420,768 × 18] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ No     : num [1:420768] 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ year   : num [1:420768] 2013 2013 2013 2013 2013 ...
    ##  $ month  : num [1:420768] 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ day    : num [1:420768] 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ hour   : num [1:420768] 0 1 2 3 4 5 6 7 8 9 ...
    ##  $ PM2.5  : num [1:420768] 4 8 7 6 3 5 3 3 3 3 ...
    ##  $ PM10   : num [1:420768] 4 8 7 6 3 5 3 6 6 8 ...
    ##  $ SO2    : num [1:420768] 4 4 5 11 12 18 18 19 16 12 ...
    ##  $ NO2    : num [1:420768] 7 7 10 11 12 18 32 41 43 28 ...
    ##  $ CO     : num [1:420768] 300 300 300 300 300 400 500 500 500 400 ...
    ##  $ O3     : num [1:420768] 77 77 73 72 72 66 50 43 45 59 ...
    ##  $ TEMP   : num [1:420768] -0.7 -1.1 -1.1 -1.4 -2 -2.2 -2.6 -1.6 0.1 1.2 ...
    ##  $ PRES   : num [1:420768] 1023 1023 1024 1024 1025 ...
    ##  $ DEWP   : num [1:420768] -18.8 -18.2 -18.2 -19.4 -19.5 -19.6 -19.1 -19.1 -19.2 -19.3 ...
    ##  $ RAIN   : num [1:420768] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ wd     : chr [1:420768] "NNW" "N" "NNW" "NW" ...
    ##  $ WSPM   : num [1:420768] 4.4 4.7 5.6 3.1 2 3.7 2.5 3.8 4.1 2.6 ...
    ##  $ station: chr [1:420768] "Aotizhongxin" "Aotizhongxin" "Aotizhongxin" "Aotizhongxin" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   No = col_double(),
    ##   ..   year = col_double(),
    ##   ..   month = col_double(),
    ##   ..   day = col_double(),
    ##   ..   hour = col_double(),
    ##   ..   PM2.5 = col_double(),
    ##   ..   PM10 = col_double(),
    ##   ..   SO2 = col_double(),
    ##   ..   NO2 = col_double(),
    ##   ..   CO = col_double(),
    ##   ..   O3 = col_double(),
    ##   ..   TEMP = col_double(),
    ##   ..   PRES = col_double(),
    ##   ..   DEWP = col_double(),
    ##   ..   RAIN = col_double(),
    ##   ..   wd = col_character(),
    ##   ..   WSPM = col_double(),
    ##   ..   station = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

# Data Wrangling

We are interested to determine how PM2.5 has changed over two time
periods - between March 1 2013 to Feb 28 2015, and March 1 2015 to Feb
28 2017. As such, we will drop all irrelevant columns, and only kept
year, month, PM2.5. We have also created a derived column ‘class’, which
will act as our target variable.

    ## # A tibble: 420,768 × 4
    ##     year month PM2.5 class   
    ##    <dbl> <dbl> <dbl> <chr>   
    ##  1  2013     3     4 Sample_A
    ##  2  2013     3     8 Sample_A
    ##  3  2013     3     7 Sample_A
    ##  4  2013     3     6 Sample_A
    ##  5  2013     3     3 Sample_A
    ##  6  2013     3     5 Sample_A
    ##  7  2013     3     3 Sample_A
    ##  8  2013     3     3 Sample_A
    ##  9  2013     3     3 Sample_A
    ## 10  2013     3     3 Sample_A
    ## # … with 420,758 more rows

Figure 1. Processed dataset with new derived column (sample).

# Exploratory analysis on the training data set

We will perform exploratory data analysis steps to highlight the
distribution of PM2.5 data points for both sample A and sample B.

![](Beijing_air_quality_files/figure-gfm/EDA%20boxplot%20and%20density%20plot-1.png)<!-- -->

Figure 2. Boxplot and Density plot for both samples’ PM2.5 distribution.
(Black dots represent the mean PM2.5 value of each sample).

Both samples are heavily right skewed. Sample A has a higher median and
mean PM2.5 value than Sample B, and its data distribution is wider than
B. It is fair to conclude that the median and mean values are too
similar to make a definitive statement as to whether the air quality has
changed over these two time frames.

Beijing Air Quality Analysis Final Report
================
Jacqueline Chong, Junrong Zhu, Macy Chan, Vadim Taskaev
11/24/2021

-   [Summary](#summary)
-   [Introduction](#introduction)
-   [Methods](#methods)
    -   [Sub Exploratory Questions:](#sub-exploratory-questions)
    -   [**Data Wrangling:**](#data-wrangling)
    -   [**Hypothesis Testing:**](#hypothesis-testing)
-   [Results & Discussion](#results--discussion)
-   [References](#references)

## Summary

I am a summary. ¯\_(ツ)\_/¯

## Introduction

The objective of this project is to answer the following inferential
question: **Have the levels of PM2.5 air pollution in Beijing, China
decreased between the Mar 2013 - Feb 2015 and Mar 2015 - Feb 2017 time
intervals, thus suggesting an improvement in overall air quality**?

The capital city of Beijing, China has long struggled with poor air
quality, a result of the country’s rapid industrialization and its heavy
reliance on coal for electricity generation the North, as well as its
growing and increasingly urban middle class (Wang and Hao 2012). This
analysis question is important for its timely and global implications.
As air pollution from the burning of fossil fuels and its association
with climate change and direct health outcomes poses a challenge to
nations worldwide, we explore whether we may find evidence of economic
growth coinciding with improving air quality. In fact, in September
2021, the World Health Organization revised its air quality guidelines
to more restrictive levels following the increasingly evident causal
relationships between poor air quality and its harmful health
consequences on impacted mainly urban communities (Organization et al.
2021).

We analyse the `Beijing Air Quality` data set, donated to the UC Irvine
Machine Learning Repository in 2019 (accessible via
[URL](https://archive-beta.ics.uci.edu/ml/datasets/beijing+multi+site+air+quality+data)),
which comprises hourly measurement of six air pollutants (including
`PM2.5`, `PM10`, `SO2`, `NO2`, `CO`, `O3`) and six meteorological
variables spanning from 2013 until 2017 across twelve of its
metropolitan data-collecting stations. While the structure of this data
set makes it suitable for multi-variate time-series regression analysis,
we focus our analysis solely on the readings of the `PM2.5` metric, a
form of fine particulate matter that is considered especially harmful
for its ability to penetrate deep into the lungs and cause long-lasting
damage to the respiratory system (Xing et al. 2016).

The report for our exploratory data analysis can be found
[here](https://github.com/UBC-MDS/DSCI_522_Beijing_Air_Quality/blob/main/src/Beijing_air_quality_EDA.md).

## Methods

### Sub Exploratory Questions:

Through Exploratory Data Analysis, we looking into the following
sub-questions:

1.  How does the distribution of air quality data observations look
    like? Are they normally distributed?
2.  If we split the data into sub data sets based on time frames, will
    there be any overlap in the ranges of the samples?

We answer the main question of this project using the following
methodology pipeline. Based on the theoretical assumption that data
points across both samples are independent and identically distributed
(i.i.d.) when their hourly collected data are distributed over
multi-year time span, we performed a hypothesis test to determine
whether there is statistical evidence to indicate an improvement in
PM2.5 measurements in Beijing between 2013 and 2017. To do so, we
implemented a one-tailed hypothesis test to answer to compare these
measurements between two equal-interval time intervals (`time_A` and
`time_B`), which we state as:

-   Null Hypothesis (*H*<sub>0</sub>): There is no statistically
    significant decrease in median PM2.5 value in Beijing between time_A
    and time_B (i.e.,
    *m**e**d**i**a**n*<sub>*P**M*2.5<sub>*t**i**m**e*<sub>*A*</sub></sub></sub> ≤ *m**e**d**i**a**n*<sub>*P**M*2.5<sub>*t**i**m**e*<sub>*B*</sub></sub></sub>)
    (Point estimate of PM2.5 in time_A is less than and equal to the
    point estimate of PM2.5 in time_B), and

-   Alternative Hypothesis (*H*<sub>*A*</sub>): There is a statistically
    significant decrease in median PM2.5 value in Beijing between time_A
    and time_B
    (*m**e**d**i**a**n*<sub>*P**M*2.5<sub>*t**i**m**e*<sub>*A*</sub></sub></sub> \> *m**e**d**i**a**n*<sub>*P**M*2.5<sub>*t**i**m**e*<sub>*B*</sub></sub></sub>)
    (Point estimate of PM2.5 in time_A is greater than the point
    estimate of PM2.5 in time_B).

### **Data Wrangling:**

We will combine data from twelve data collection stations across Beijing
into one data frame and split them into the following two time frames:

-   *t**i**m**e*\_*A*: PM2.5 measurements from March 2013 until February
    2015 (inclusive)

-   *t**i**m**e*\_*B*: PM2.5 measurements from March 2015 until February
    2017 (inclusive)

### **Hypothesis Testing:**

Hypothesis test for independence of a difference in medians using
permutation is a suitable test to answer our main question, given that
the suitable estimator is median and each data point is collected
independently from several testing stations and independent time unit.
Our pre-specified significance level is *α* = 0.05 (the probability for
us to reject the null hypothesis)

-   Null Hypothesis(*H*<sub>0</sub>): The measurement of PM2.5 in
    Beijing from time_B does not show any sign of improvement comparing
    to time_A. (Point estimate of PM2.5 in time_B ≥ the point estimate
    of PM2.5 in time_A)

-   Alternative Hypothesis(*H*<sub>*a*</sub>): The measurement of PM2.5
    in Beijing from time_B shows an improvement comparing to time_A.
    (Point estimate of PM2.5 in time_B is \< the point estimate of PM2.5
    in time_A)

After conducting the permutation test in the difference of medians, we
get a p-value, which is 1

which is greater than the significance level *α* = 0.05.

The result indicates that we do not have enough statistical evidence to
reject the null hypothesis, *H*<sub>0</sub>. Hence, there is no
statistically significant difference between the median PM2.5
measurement for time_B and time_A in Beijing.

## Results & Discussion

Result is no result

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-world2021global" class="csl-entry">

Organization, World Health et al. 2021. “WHO Global Air Quality
Guidelines: Particulate Matter (Pm2. 5 and Pm10), Ozone, Nitrogen
Dioxide, Sulfur Dioxide and Carbon Monoxide: Executive Summary.”

</div>

<div id="ref-wang2012air" class="csl-entry">

Wang, Shuxiao, and Jiming Hao. 2012. “Air Quality Management in China:
Issues, Challenges, and Options.” *Journal of Environmental Sciences* 24
(1): 2–13.

</div>

<div id="ref-xing2016impact" class="csl-entry">

Xing, Yu-Fei, Yue-Hua Xu, Min-Hua Shi, and Yi-Xin Lian. 2016. “The
Impact of Pm2. 5 on the Human Respiratory System.” *Journal of Thoracic
Disease* 8 (1): E69.

</div>

</div>

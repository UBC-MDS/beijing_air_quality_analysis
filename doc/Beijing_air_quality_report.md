Beijing Air Quality Analysis Final Report
================
Jacqueline Chong, Junrong Zhu, Macy Chan, Vadim Taskaev
11/24/2021

## Summary

I am a summary. ¯\_(ツ)\_/¯

## Introduction

The objective of this project is to answer the following inferential
question: **Does PM2.5 measurement in Beijing, China collected between
2013 and 2017 show any sign of improvement?**

The capital city of Beijing, China has long struggled with poor air
quality, a result of the country’s rapid industrialization and its heavy
reliance on coal for electricity generation the North, as well as its
growing and increasingly urban middle class (Wang, Hao. 2012 Jan; 24(1):
2-13). This analysis question is important for its timely and global
implications: as air pollution from the burning of fossil fuels and its
association with climate change and direct health outcomes poses a
challenge to nations worldwide, we explore whether we may find evidence
of economic growth coinciding with improving air quality. In fact, in
September 2021, the World Health Organization revised its air quality
guidelines to more restrictive levels following the increasingly evident
causal relationships between poor air quality and its harmful health
consequences on impacted mainly urban communities (Whaley,
Nieuwenhuijsen, Burns. 2021 Sep; 142).

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
damage to the respiratory system (J Thorac Dis. 2016 Jan; 8(1):
E69–E74).

## Methods

### Sub Exploratory Questions:

1.  How does the distribution of air quality data observations look
    like? Are they normally distributed?
2.  If we split the data into sub data sets based on time frames, will
    there be any overlap in the ranges of the samples?

In order to explore the data set while answering the sub questions, we
will perform further steps as below to get better understanding for the
main question.

### **Data Wrangling:**

We will combine sub data-sets, which were collected from twelve testing
locations in Beijing, into one data frame, and then split this data
frame into two samples based on time frames below.

-   time_A: air quality data from March 2013 - February 2015

-   time_B: air quality data from March 2015 - February 2017

### **Hypothesis Testing:**

Given that we have good sample size for both samples and the data points
are independent, we will perform a hypothesis test to determine whether
there is statistical evidence to indicate an improvement in PM2.5
measurements in Beijing between 2013 and year 2017. We will implement
one-tailed test to answer the question since we expect to detect the
improvement in PM2.5 pollution.

-   Null Hypothesis(\*H\*\<sub>0\</sub>): The measurement of PM2.5 in
    Beijing from time_B does not show any sign of improvement comparing
    to time_A. (Point estimate of PM2.5 in time_A is less than and equal
    to the point estimate of PM2.5 in time_B)

-   Alternative Hypothesis(*H*<sub>0</sub>): The measurement of PM2.5 in
    Beijing from time_B shows an improvement comparing to time_A. (Point
    estimate of PM2.5 in time_A is greater than the point estimate of
    PM2.5 in time_B)

We will perform exploratory data analysis steps to identify and
demonstrate the unique patterns and distributions of PM2.5 data points
for time_A and time_B data sets, and then pick the appropriate estimator
from our observation to answer the inferential question on PM2.5
pollutant.

## Results & Discussion

Result is no result

# References

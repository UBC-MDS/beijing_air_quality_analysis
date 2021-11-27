Beijing Air Quality Analysis Final Report
================
Jacqueline Chong, Junrong Zhu, Macy Chan, Vadim Taskaev
11/24/2021

## Summary

This analysis project aims to answer whether the levels of PM2.5 air
pollution in Beijing, China has improved between 2013 and 2017. To do
so, we performed a difference in medians hypothesis test between two
intervals, `time_A` (March 2013 - February 2015) and `time_B` (March
2015 - February 2017), and concluded that no statistically significant
decrease in PM2.5 particulate measurements can be detected.

This result has economic implications, informing us about China’s
economic growth trajectory. Based on the Kuznets curve, it suggests that
China’s per capita income has much to grow since the PM2.5 median value
has remained constant or is increasing.

![](/Users/macychan/UBC%20MDS/522_Data_Science_Workflows/DSCI_522_Beijing_Air_Quality/resource/Environmental_Kuznets_Curve.jpeg)<!-- -->

Figure 1: China has yet to reach the point of inflexion (Sanders 2017)

\*The model suggests that economic development initially leads to a
deterioration in the environment, but will improve in its relationship
past a certain level of economic growth.

## Introduction

The objective of this project is to answer the following inferential
question: **Does PM2.5 measurement in Beijing, China collected between
2013 and 2017 show any sign of improvement?**

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
consequences on impacted mainly urban communities (WHO 2021).

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

## Methodology

We combine the data from twelve data collection stations across Beijing
into one data frame and split them into the following two time frames:

-   `time_A`: PM2.5 measurements from March 2013 until February 2015
    (inclusive)

-   `time_B`: PM2.5 measurements from March 2015 until February 2017
    (inclusive)

Through Exploratory Data Analysis, we identify that our data is heavily
skewed and more suitable to analyze the median.

![](/Users/macychan/UBC%20MDS/522_Data_Science_Workflows/DSCI_522_Beijing_Air_Quality/results/combined_distribution_plot_1.png)<!-- -->

Figure 2. Both time_A and time_B distributions are right-skewed

We answer the main question of this project using the following
methodology pipeline. Based on the theoretical assumption that data
points across both samples are independent and identically distributed
(i.i.d.) when their hourly collected data are distributed over
multi-year time span, we performed a hypothesis test to determine
whether there is statistical evidence to indicate an improvement in
PM2.5 measurements in Beijing between 2013 and 2017. To do so, we
implement a one-tailed hypothesis test to answer to compare these
measurements between two equal-interval time intervals (`time_A` and
`time_B`).

### Hypothesis Testing

We use a hypothesis test for independence of a difference in medians via
permutation to answer the main question main, using a significance level
of *α* = 0.05.

-   Null Hypothesis (*H*<sub>0</sub>): The median PM2.5 value in Beijing
    in time_A is less than or equal to the median PM2.5 value in time_B
    (*Q*<sub>*A*</sub>(0.5) ≤ *Q*<sub>*B*</sub>(0.5))

-   Alternative Hypothesis (*H*<sub>*A*</sub>): There median PM2.5 value
    in Beijing in time_A is greater than the median PM2.5 values in
    time_B (*Q*<sub>*A*</sub>(0.5) \> *Q*<sub>*B*</sub>(0.5))

## Results and Discussion

![](/Users/macychan/UBC%20MDS/522_Data_Science_Workflows/DSCI_522_Beijing_Air_Quality/results/violin_plot.png)<!-- -->

Figure 3. Violin Plot showing that there is a difference in median PM2.5
value in time_A and time_B

There is a difference in median values as seen in the violin plot.
However, after conducting the permutation test in the difference of
medians, we get a p-value of 1, which is greater than the significance
level *α* = 0.05.

The result indicates that we do not have enough statistical evidence to
reject the null hypothesis, *H*<sub>0</sub>. Hence, there is no
statistically significant difference between the median PM2.5
measurement for time_B and time_A in Beijing.

These results illustrate that, despite increasing state attention on
improving air quality across Beijing, China’s relentless
industrialization has not provided its urban population respite from
consistently high levels of harmful PM2.5 across the metropolis.

From this analysis, we have shown that despite China’s high economic
growth from 2013 to 2017, it has not translated into improved PM2.5
levels (Statista 2021). Based on the Environmental *Keznets* Curve
Hypothesis economic model, it shows that China is still on an upward
trend (Dinda 2004).

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-dinda2004environmental" class="csl-entry">

Dinda, Soumyananda. 2004. “Environmental Kuznets Curve Hypothesis: A
Survey.” *Ecological Economics* 49 (4): 431–55.

</div>

<div id="ref-sanders_2017" class="csl-entry">

Sanders, Jon. 2017. “The Market Forces Behind North Carolina’s Falling
Emissions.” *John Locke Foundation*. John Locke Foundation.
<https://www.johnlocke.org/research/the-market-forces-behind-north-carolinas-falling-emissionsnew-research-shows-that-improvements-are-market-oriented-not-government-driven/>.

</div>

<div id="ref-chinagrowth" class="csl-entry">

Statista. 2021. “China GDP Growth Rate 2011-2024.” *Statista*.
<https://www.statista.com/statistics/263616/gross-domestic-product-gdp-growth-rate-in-china/>.

</div>

<div id="ref-wang2012air" class="csl-entry">

Wang, Shuxiao, and Jiming Hao. 2012. “Air Quality Management in China:
Issues, Challenges, and Options.” *Journal of Environmental Sciences* 24
(1): 2–13.

</div>

<div id="ref-world2021global" class="csl-entry">

WHO. 2021. “WHO Global Air Quality Guidelines: Particulate Matter (Pm2.
5 and Pm10), Ozone, Nitrogen Dioxide, Sulfur Dioxide and Carbon
Monoxide: Executive Summary.”

</div>

<div id="ref-xing2016impact" class="csl-entry">

Xing, Yu-Fei, Yue-Hua Xu, Min-Hua Shi, and Yi-Xin Lian. 2016. “The
Impact of Pm2. 5 on the Human Respiratory System.” *Journal of Thoracic
Disease* 8 (1): E69.

</div>

</div>

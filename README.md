---
output: github_document
bibliography: doc/beijing_air_quality.bib
---

# Beijing Air Quality Analysis

-   Authors: Jacqueline Chong, Junrong Zhu, Macy Chan, Vadim Taskaev

Data analysis project for DSCI 522 (Data Science Workflows); a course in the Master of Data Science program at the University of British Columbia.

## Introduction

The objective of this project is to answer the following question: do PM2.5 measurements in Beijing, China collected between 2013 and 2017 show seasonal and/or longer-term consistent signs of improvement?

The capital city of Beijing, China has long struggled with poor air quality, a result of the country's rapid industrialization and its heavy reliance on coal for electricity generation the North, as well as its growing and increasingly urban middle class (Wang, Hao. 2012 Jan; 24(1): 2-13). This analysis question is important for its timely and global implications: as air pollution from the burning of fossil fuels and its association with climate change and direct health outcomes poses a challenge to nations worldwide, we explore whether we may find evidence of economic growth coinciding with improving air quality. In fact, in September 2021 the World Health Organization revised its air quality guidelines to more restrictive levels following the increasingly evident causal relationships between poor air quality and its harmful health consequences on impacted mainly urban communities (Whaley, Nieuwenhuijsen, Burns. 2021 Sep; 142).

We analyse the `Beijing Air Quality` data set, donated to the UC Irvine Machine Learning Repository in 2019, which comprises hourly measurement of six air pollutants (including `PM2.5`, `PM10`, `SO2`, `NO2`, `CO`, `O3`) and six meteorological variables spanning from 2013 until 2017 across twelve of its metropolitan data-collecting stations. While the structure of this data set makes it suitable for multi-variate time-series regression analysis, we focus our analysis solely on the readings of the `PM2.5` metric, a form of fine particulate matter that is considered especially harmful for its ability to penetrate deep into the lungs and cause long-lasting damage to the respiratory system (J Thorac Dis. 2016 Jan; 8(1): E69--E74).

## Usage

## Dependencies {#dependencies}

## License

# References

::: {#refs .references} <div>

Whaley P, Nieuwenhuijsen M, Burns J. 2021. "Update of the WHO global air quality guidelines: systematic reviews". In *Environ Int.* 142(Special issue) (<https://www.sciencedirect.com/journal/environment-international/special-issue/10MTC4W8FXJ>)

Yu-Fei Xing, Yue-Hua Xu, Min-Hua Shi, and Yi-Xin Lian. 2016. "The impact of PM2.5 on the human respiratory system". In *Journal of Thoracic Disease.* 8(1): E69--E74. (<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4740125/>)

Wang, Shuxiao, and Hao, Jiming. 2012. "Air quality management in China: Issues, challenges, and options." In *Journal of Environmental Sciences*. 24(1). (<https://www.sciencedirect.com/science/article/abs/pii/S1001074211607249>)

</div>

:::

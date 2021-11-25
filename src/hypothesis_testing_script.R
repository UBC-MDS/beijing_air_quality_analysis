# author: Junrong Zhu
# date: 2021-11-24

"Hypothesis Testing

Usage: src/beijing_air_quality.rmd --data=<data> --out_dir=<out_dir>
  
Options:
--input=<input>        Path (including filename) to input the preprocessed data
--out_dir=<out_dir>  path to directory where the file should be saved
" -> doc

#input path example : here("data", "raw","PRSA_Data_20130301-20170228")

library(docopt)
library(tidyverse)
library(infer)
library(knitr)
library(cowplot)
library(here)
set.seed(2021)

opt <- docopt(doc)

main <- function(input, out_dir){
  
  #loading the preprocessed data
  pm_data <- read_feather(input)
  
  #simulation based permutation test
  null_distribution <- pm_data |> 
    specify(PM2.5 ~ class) |> 
    hypothesis(null = "independence") |> 
    generate(reps = 2000, type = "permutate") |> 
    calculate(stat = "diff in medians",
              order = c("time_B", "time_A"))
  
  #observed test statistic
  obs_diff_median <- pm_data |> 
    specify(PM2.5 ~ class) |> 
    calculate(stat = "diff in medians",
              order = c("time_B", "time_A"))
  
  #calculating p-value
  p_value <- get_p_value(null_distribution, 
                         obs_stat = obs_diff_median, 
                         direction = "less")
  
  #visualizing null distribution with shaded p-value
  dist_visual <- visualizae(null_distribution, bins = 30) +
    shade_p_value(obs_stat = obs_diff_median, direction = "less",
                  fill = "lightblue")
  
  #save the p-value for analysis file
  save(p_value, file = paste0(out_dir, "/hypothesis_testing_p_value.rds"))
  
  #save plot of null distribution
  ggsave("null_distribution_plot", dist_visual, 
         path = out_dir)
}


main(opt[["--input"]], opt[["--out_dir"]])

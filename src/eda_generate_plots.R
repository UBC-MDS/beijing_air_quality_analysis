# author:
# date: 2021-11-24

"Generate EDA Plots

Usage: src/pre_process_data.R --data=<data> --out_dir=<out_dir>

Options:
--input=<input>      path with processed csv for EDA plots generation
--out_dir=<out_dir>  path of output (EDA plots)
" -> doc

# Rscript src/eda_generate_plots.R --data=data/processed/PRSA_Data_processed.csv --out_dir=results
# TODO:
# 1. read the processed data in data/processed/PRSA_Data_processed.csv/rds
# 2. Output plots to to results

library(docopt)
library(tidyverse)
library(infer)
library(knitr)
library(cowplot)
set.seed(2021)

opt <- docopt(doc)

main <- function(input, out_dir){
  
  #loading the preprocessed data
  pm_data <- rad_feather(input)
  
  #simulation based permutation test
  null_distribution <- pm_data |> 
    specify(PM2.5 ~ class) |> 
    hypothesis(null = "independence") |> 
    generate(reps = 2000, type = "permutate") |> 
    calculate(stat = "diff in medians",
              order = c("time_A", "time_B"))
  
  #observed test statistic
  obs_diff_median <- pm_data |> 
    specify(PM2.5 ~ class) |> 
    calculate(stat = "diff in medians",
              order = c("time_A", "time_B"))
  
  #calculating p-value
  p_value <- get_p_value(null_distribution, 
                         obs_stat = obs_diff_median, 
                         direction = "greater")
  
  #visualizing null distribution with shaded p-value
  dist_visual <- visualizae(null_distribution, bins = 30) +
    shade_p_value(obs_stat = obs_diff_median, direction = "greater",
                  fill = "lightblue")
  
  saveRDS(p_value, file = paste0(out_dir, "/hypothesis_testing_p_value.rds"))
  #!!!
}


main(opt[["--input"]], opt[["--out_dir"]])

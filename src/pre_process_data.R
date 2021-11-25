# author:
# date: 2021-11-24

"Preprocess PRSA Data

Usage: src/pre_process_data.R --data=<data> --out_dir=<out_dir>

Options:
--input=<input>      path with all unziped csv for data preprocess
--out_dir=<out_dir>  path of output (a preprocessd csv file)
" -> doc

# Rscript src/pre_process_data.R --data=data/raw/PRSA_Data_20130301-20170228 --out_dir=data/processed
# TODO:
# 1. read all the files in data/raw/PRSA_Data_20130301-20170228
# 2. Output the rds/csv folder to data/processed

library(docopt)
library(tidyverse)
library(infer)
library(knitr)
library(cowplot)
set.seed(2021)

opt <- docopt(doc)

main <- function(input, out_dir){
  
  csv_list <- dir(input)
  
  air_data <- data.frame()
  for (file_name in csv_list) {
    air_data <- rbind(air_data,
                      read_csv(
                        here("data",
                             "raw", 
                             "PRSA_Data_20130301-20170228", 
                             file_name), 
                        show_col_types = FALSE))
  }
  
  head(air_data)
  
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

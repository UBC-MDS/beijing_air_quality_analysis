# author: Junrong Zhu
# date: 2021-11-24

"Hypothesis Testing

Usage:src/hypothesis_testing_script.R --input=<input> --out_dir=<out_dir>
  
Options:
--input=<input>       Path (including filename) to input the preprocessed data
--out_dir=<out_dir>   Path to directory where the file should be saved
" -> doc

#input path example : data/processed/processed_data.csv
#Rscript src/hypothesis_testing_script.R --input=data/processed/processed_data.csv --out_dir=results

library(docopt)
library(tidyverse)
library(infer)
library(cowplot)
library(here)


opt <- docopt(doc)

main <- function(input, out_dir){
 
  #loading the preprocessed data
  pm_data <- read_csv(input)
  set.seed(2021)

  #simulation based permutation test
  null_distribution <- pm_data |>
    specify(PM2.5 ~ class) |>
    hypothesize(null = "independence") |>
    generate(reps = 10, type = "permute") |>
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
                         direction = "less")
  print(p_value)
  #visualizing null distribution with shaded p-value
  dist_visual <- visualize(null_distribution, bins = 50) +
    shade_p_value(obs_stat = obs_diff_median, direction = "less",
                  fill = "lightblue")

  #save the p-value for analysis file
  #save(p_value, file = paste0(out_dir, "/hypothesis_testing_p_value.csv"))


  if(!file.exists(out_dir)){
    dir.create(out_dir)
  }
  
  #save plot of null distribution
  ggsave("null_distribution_plot.png", 
         plot = dist_visual,
         path = here(out_dir))
  
}

main(opt[["--input"]], opt[["--out_dir"]])

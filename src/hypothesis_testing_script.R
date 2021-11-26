"Hypothesis Testing

Usage:src/hypothesis_testing_script.R --input=<input> --out_dir=<out_dir>
  
Options:
--input=<input>       Path (including filename) to input the preprocessed data
--out_dir=<out_dir>   Path to directory where the file should be saved
" -> doc

library(docopt)
library(tidyverse)
library(infer)
library(cowplot)
library(here)

opt <- docopt(doc)

main <- function(input, out_dir){
 
  #loading the preprocessed data
  pm_data <- read_csv(input)

  #creating the function to get 95% confidence interval
  ci_median <- function(sample, var, level = 0.95, type = 'percentile') {
    set.seed(2021)
    sample |>
      rep_sample_n(nrow(sample), replace = TRUE, reps = 10) |>
      summarise(stat = median({{ var }})) |>
      get_confidence_interval(level = level, type = type)
   }
  
  # Calculate medians for each class
  medians <- pm_data |>
    group_by(class) |>
    summarise(median = median(PM2.5))
  
  # Calculate 95% CIs using ci_median
  median_est <- pm_data |>
    group_by(class) |>
    nest() |>
    mutate(ci = map(data, ~ci_median(., PM2.5))) |>
    unnest(c(data, ci)) |>
    left_join(medians) |>
    group_by(class) |>
    nest(data = c(PM2.5))
  
  # compute observed test statistic delta_star
  delta_star <- median_est |>
    pull(median) |>
    diff()
  
  #simulation based permutation test
  null_distribution <- pm_data |>
    specify(PM2.5 ~ class) |>
    hypothesize(null = "independence") |>
    generate(reps = 50, type = "permute") |>
    calculate(stat = "diff in medians",
              order = c("time_B", "time_A"))

  #get the p-value
  pvalue <- get_p_value(null_distribution, 
                        obs_stat = delta_star, direction = 'less')
  
  violin_plot <- ggplot(pm_data, aes(x = class, y = PM2.5))+
    geom_violin(trim = TRUE, width = 0.5)+
    geom_point(data = median_est, aes(x = class, y = median))+
    geom_errorbar(data = median_est, aes(x = class, 
                                         y = median, 
                                         ymin= lower_ci, 
                                         ymax = upper_ci, 
                                         color = "orange", width = 0.05))+
    ylim(c(0, 500))+
    labs(x = "", color = "Median", 
         title = "Measurement of PM2.5 from both time periods in Beijing")
  
  if(!file.exists(out_dir)){
    dir.create(out_dir)
  }
  
  #save plot of null distribution
  ggsave("violin_plot.png", 
         plot = violin_plot,
         path = here(out_dir))
  
}

main(opt[["--input"]], opt[["--out_dir"]])

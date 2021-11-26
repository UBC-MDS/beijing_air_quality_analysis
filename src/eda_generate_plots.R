# author: Macy Chan
# date: 2021-11-24

"Generate EDA Plots

Usage: src/eda_generate_plots.R --input=<input> --out_dir=<out_dir>

Options:
--input=<input>         path with processed csv for EDA plots generation
--out_dir=<out_dir>     path of output (EDA plots)
" -> doc

# Rscript src/eda_generate_plots.R --input=data/processed/processed_data.csv --out_dir=results
# TODO:
# 1. read the processed data in data/processed/processed_data.csv
# 2. Output plots to to results

library(docopt)
library(tidyverse)
library(cowplot)
library(here)

opt <- docopt(doc)

main <- function(input, out_dir) {
  
        #loading the preprocessed data
        air_data_processed <- read_csv(here(input))
        
        #Box Plot and Histogram
        time_A_B_boxplot <- air_data_processed |>
                group_by(class) |>
                ggplot(aes(x=PM2.5, y=class, fill = class)) +
                geom_boxplot(names=c('time_A', 'time_B'), 
                             outlier.alpha = 0.1,
                             outlier.fill = NULL) +
                geom_point(stat = 'summary', fun = 'mean', color = 'black') +
                labs(title = 'Box Plot and Histogram PM2.5 Distribution per Time Frame',
                     subtitle = 'time_A has a higher median and mean value than time_B \ntime_A and time_B are both heavily right-skewed') +
                theme(axis.title.y = element_blank(),
                      axis.text.y = element_blank(),
                      axis.ticks.y = element_blank(),
                      axis.title.x = element_blank(),
                      axis.text.x = element_blank())
        
        histogram <- air_data_processed |>
                ggplot(aes(x=PM2.5, fill=class)) +
                geom_histogram(bins=30) +
                facet_wrap(~class, ncol = 1) +
                theme(axis.title.y = element_blank(),
                      axis.text.y = element_blank(),
                      axis.ticks.y = element_blank())
        
        
        combined_distribution_plot <- plot_grid(
                plot_grid(ggplot(),
                          time_A_B_boxplot,
                          rel_widths = c(1,70)),
                plot_grid(histogram + theme(legend.position = 'none'),
                          ggplot(),
                          ncol=2,
                          rel_widths = c(12,1.75)),
                ncol=1)
        
        time_A_B_distribution <- air_data_processed |>
                group_by(class) |>
                ggplot(aes(x=log(PM2.5), fill = class)) +
                geom_density(alpha = 0.4) +
                theme(axis.title.y=element_blank(),
                      axis.text.y = element_blank(),
                      axis.ticks.y = element_blank()) +
                geom_vline(xintercept = 4.1, color = 'purple') +
                geom_vline(xintercept = 1.3, color = 'orange') +
                labs(x = 'PM2.5 level (log(ug/m^3))',
                     title = 'Density Plot of PM2.5 Log-Distribution per Time Frame',
                     subtitle = 'time_A has more lower and upper extreme values than time_B')
        
        
        if(!file.exists(out_dir)){
                dir.create(out_dir)
        }
        
        #save plot of null distribution
        ggsave("combined_distribution_plot_1.png", 
               plot = combined_distribution_plot,
               path = here(out_dir))

        ggsave("time_A_B_distribution.png", 
               plot = time_A_B_distribution,
               path = here(out_dir))      
        
}

main(opt[["--input"]], opt[["--out_dir"]])

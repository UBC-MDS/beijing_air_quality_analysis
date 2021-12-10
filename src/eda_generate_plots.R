"Generate EDA Plots

Usage: src/eda_generate_plots.R --input=<input> --out_dir=<out_dir>

Options:
--input=<input>         path with processed csv for EDA plots generation
--out_dir=<out_dir>     path of output (EDA plots)
" -> doc

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
              geom_boxplot(outlier.alpha = 0.1,
                          outlier.fill = NULL) +
              geom_point(stat = 'summary', fun = 'mean', color = 'black') +
              labs(title = 'Box Plot and Histogram PM2.5 Distribution',
                  subtitle = 'plots over both Time Frame(time_A, time_B)') +
             labs(x="PM2.5 measurement",
                  y="")+
              theme(text = element_text(size = 18))+
              theme_bw()
        
        histogram <- air_data_processed |>
                ggplot(aes(x=PM2.5, fill=class)) +
                geom_histogram(bins=30) +
                facet_wrap(~class, ncol = 1) +
                theme(axis.title.y = element_blank(),
                      axis.text.y = element_blank(),
                      axis.ticks.y = element_blank())+
                theme_bw()+
                theme(text = element_text(size = 18))
        
        
        combined_distribution_plot <- plot_grid(time_A_B_boxplot,
                                                histogram, ncol=1)
        
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
                     subtitle = 'time_A has more lower and upper extreme values than time_B')+
                theme_bw()
        
        
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

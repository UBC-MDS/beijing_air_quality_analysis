"Preprocess PRSA Data

Usage: src/pre_process_data.R --input=<input> --out_dir=<out_dir>

Options:
--input=<input>      path with all unziped csv for data preprocess
--out_dir=<out_dir>  path of output (a preprocessd csv file)
" -> doc

library(docopt)
library(tidyverse)
library(here)

opt <- docopt(doc)

main <- function(input, out_dir) {
  csv_list <- dir(path = input)
  
  air_data <- data.frame()
  for (file_name in csv_list) {
    air_data <- rbind(air_data,
                      read_csv(here(input, file_name),
                               show_col_types = FALSE))
  }
  
  air_data_processed <- air_data |>
    select(year, month, PM2.5) |>
    drop_na(PM2.5) |>
    mutate(class = ifelse((year >= 2013 &
                             year <= 2014) |
                            (year == 2015 & month <= 2),
                          'time_A',
                          'time_B'
    ))
  
  if (!file.exists(out_dir)) {
    dir.create(out_dir)
  }
  
  write.csv(air_data_processed, paste0(out_dir, "/processed_data.csv"))
  
}

main(opt[["--input"]], opt[["--out_dir"]])

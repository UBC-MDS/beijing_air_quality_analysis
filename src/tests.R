test_that("Incorrect output result", {
  expect_equal(length(ci_median(air_data_processed, PM2.5)), 2)
  expect_false(
    ci_median(air_data_processed, PM2.5)[2] < 
      ci_median(air_data_processed, PM2.5)[1]
    )
})

test_that("Function has inappropriate input type", {
  expect_error(ci_median(c(1, 2, 3), class))
  expect_error(ci_median("air_data_processed", class))
})


#preventative checking
ci_median <- function(sample, var, level = 0.95, type = 'percentile') {
  if(!is.data.frame(sample)){
    stop("Input sample must be dataframe")
  }
  set.seed(2021)
  sample |>
    rep_sample_n(nrow(sample), replace = TRUE, reps = 10) |>
    summarise(stat = median({{ var }})) |>
    get_confidence_interval(level = level, type = type)
}
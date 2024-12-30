## code to prepare `rreas_comu` dataset goes here
rreas_comu <- readr::read_csv("data-raw/rreas/comu_rreas.csv")

usethis::use_data(rreas_comu, overwrite = TRUE)

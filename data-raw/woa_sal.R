## code to prepare `woa_long` dataset goes here
library(dplyr)
library(readr)
library(tidyr)

# Download 2023 World Ocean Atlas *salinity* from NCEI. TODO: put on Drive.
# Place the file in data-raw, but don't commit it! It's pretty big.

# Read wide-format data
woa_sal <- read.csv("data-raw/woa_sal.csv", skip = 1)
woa_sal <- woa_sal[, 1:3]
colnames(woa_sal) <- c("latitude", "longitude", "salinity")

usethis::use_data(woa_sal, overwrite = TRUE)

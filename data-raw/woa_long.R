## code to prepare `woa_long` dataset goes here
library(dplyr)
library(readr)
library(tidyr)

# Download 2023 World Ocean Atlas from NCEI, or my copy on Drive
# https://drive.google.com/file/d/1hDWoT69ju03iWEORK4a0uu2r31_DCtFb/view?usp=sharing
# Place the file in data-raw, but don't commit it! It's pretty big.

# Read wide-format data
depths <- c(
  seq(0, 100, by = 5),
  seq(125, 500, by = 25),
  seq(550, 2000, by = 50),
  seq(2100, 5500, by = 100)
)
woa_colnames <- c("latitude", "longitude", paste0("depth_", depths, "m"))
woa_wide <- read.csv("data-raw/woa.csv", skip = 1)
colnames(woa_wide) <- woa_colnames

woa_long <- pivot_longer(woa_wide,
                         -(1:2),
                         names_to = "depth_m",
                         values_to = "temp_c") %>%
  mutate(depth_m = parse_number(depth_m)) %>%
  drop_na(temp_c) %>%
  as.data.frame()

usethis::use_data(woa_long, overwrite = TRUE)

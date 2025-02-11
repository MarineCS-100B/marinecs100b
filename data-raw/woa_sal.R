## code to prepare `woa_long` dataset goes here
library(sf)
library(tidyverse)

# Download 2023 World Ocean Atlas *salinity* from NCEI. TODO: put on Drive.
# Place the file in data-raw, but don't commit it! It's pretty big.

# Read wide-format data
woa_sal_sf <- read_csv("data-raw/woa_sal.csv", skip = 1) %>%
  select(1:3) %>%
  set_names(c("latitude", "longitude", "salinity")) %>%
  st_as_sf(coords = c("longitude", "latitude"),
           crs = "+proj=latlon",
           remove = FALSE)

# Join with ocean basin data
# Global Oceans and Seas from marineregions.org
sf_use_s2(FALSE)
oceans <- st_read("data-raw/GOaS_v1_20211214/") %>%
  st_simplify(dTolerance = 0.1)
oceans <- oceans %>%
  mutate(name = case_when(
    str_detect(name, "Atlantic") ~ "Atlantic Ocean",
    str_detect(name, "Pacific") ~ "Pacific Ocean",
    TRUE ~ name
  )) %>%
  filter(name %in% c("Atlantic Ocean", "Indian Ocean", "Pacific Ocean", "Mediterranean Region")) %>%
  select(ocean = name)

# sample 1000 values, removing salinities outside range 30-40
set.seed(1234)
woa_sal <- woa_sal_sf %>%
  st_join(oceans) %>%
  drop_na(ocean) %>%
  filter(between(salinity, 30, 40)) %>%
  as.data.frame() %>%
  select(-geometry) %>%
  slice_sample(n = 1000)

usethis::use_data(woa_sal, overwrite = TRUE)

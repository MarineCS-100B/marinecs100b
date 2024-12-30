## code to prepare `cctd_meso` dataset goes here
library(tidyverse)

# Query CCTD data from ERDDAP
cctd_info <- rerddap::info(datasetid = "SWFSC-CCTD",
                           url = "https://oceanview.pfeg.noaa.gov/erddap/")
food_habits <- rerddap::tabledap(cctd_info,
                                 fields = c("predator_id",
                                            "predator_common_name",
                                            "predator_scientific_name",
                                            "prey_id",
                                            "prey_common_name",
                                            "prey_scientific_name",
                                            "prey_contents"),
                                 distinct=TRUE) %>%
  filter(prey_contents != "no") %>%
  select(-prey_contents)

# Classification of fish as mesopelagic or coastal pelagic
meso_fish <- read_csv("data-raw/cctd/Meso_fish.csv")
coastal_pelagic_fish <- c("Sardinops sagax", "Scomber japonicus", "Engraulis mordax", "Trachurus symmetricus", "Clupea pallasii pallasii","Atherinopsis californiensis")

# Join CCTD with classification
cctd_meso <- food_habits %>%
  mutate(meso_prey = prey_scientific_name %in% meso_fish$Prey_Sci_Name,
         cpf_prey = prey_scientific_name %in% coastal_pelagic_fish) %>%
  drop_na()

usethis::use_data(cctd_meso, overwrite = TRUE)

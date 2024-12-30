## code to prepare `kefj` dataset goes here

library(dplyr)
library(lubridate)
library(readr)
library(readxl)
library(sbtools)
tempdatadir <- tempdir()

# Intertidal Temperature Data from Kachemak Bay, Prince William Sound, Katmai National Park and Preserve, and Kenai Fjords National Park
# DOI: 10.5066/F7WH2N3T
sb_temp_id <- query_sb_doi("10.5066/F7WH2N3T")[[1]]$id
sb_temp_files <- item_list_files(sb_temp_id)
sb_temp_url <- sb_temp_files[sb_temp_files$fname == "Block05_KEFJ.zip", "url"]
download.file(sb_temp_url, file.path(tempdatadir, "Block05_KEFJ.zip"))
unzip(file.path(tempdatadir, "Block05_KEFJ.zip"), exdir = tempdatadir)
sb_temp_csv <- dir(file.path(tempdatadir, "Block05_KEFJ"),
                   pattern = "csv$", full.names = TRUE)
sb_temp_xlsx <- dir(file.path(tempdatadir, "Block05_KEFJ"),
                    pattern = "xlsx$", full.names = TRUE)
sb_temp_colnames <- colnames(read_csv(sb_temp_csv[1], n_max = 1))
sb_temp <- rbind(
  read_csv(sb_temp_csv, col_names = sb_temp_colnames, skip = 1),
  read_excel(sb_temp_xlsx, col_names = sb_temp_colnames, skip = 1)
) %>%
  mutate(datetime = force_tz(as.POSIXct(date) + time, "Etc/GMT+8")) %>%
  arrange(site, datetime)
unlink(tempdatadir, recursive = TRUE)

kefj_site <- sb_temp$site
kefj_datetime <- sb_temp$datetime
kefj_temperature <- sb_temp$temperature
kefj_tidelevel <- sb_temp$tidelevl
kefj_exposure <- sb_temp$exposure
kefj_season <- case_match(
  month(kefj_datetime),
  1:3 ~ "Late winter",
  4:5 ~ "Spring",
  6:7 ~ "Summer",
  8:10 ~ "Fall",
  11:12 ~ "Early winter"
) %>%
  factor(levels = c("Late winter", "Spring", "Summer", "Fall", "Early winter"))

usethis::use_data(kefj_site,
                  kefj_datetime,
                  kefj_temperature,
                  kefj_tidelevel,
                  kefj_exposure,
                  kefj_season,
                  overwrite = TRUE)



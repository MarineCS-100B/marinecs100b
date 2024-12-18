## code to prepare `calcofi_ctd` dataset goes here
library(tidyverse)

all_casts <- read_csv("data-raw/calcofi_ctd/20-1708SR_CTDBTL_001-073D.csv")

# Pull out CTD casts for stations 083.3 070.0, 083.3 110.0, 090.0 070.0, and
# 090.0 110.0
stations <- c("083.3 070.0", "083.3 110.0", "090.0 070.0", "090.0 110.0")
# Look at quick summary
all_casts %>%
  group_by(Sta_ID, Cast_ID) %>%
  summarize(Lon_Dec = mean(Lon_Dec),
            Lat_Dec = mean(Lat_Dec),
            N = n(),
            .groups = "drop") %>%
  filter(Sta_ID %in% stations)

calcofi_ctd <- all_casts %>%
  filter(Sta_ID %in% stations) %>%
  select(station_id = Sta_ID,
         depth = Depth,
         temperature = TempAve,
         salinity = SaltAve_Corr,
         datetime_utc = Date_Time_UTC,
         longitude = Lon_Dec,
         latitude = Lat_Dec) %>%
  mutate(datetime_utc = as.POSIXct(datetime_utc,
                                   format = "%d-%b-%Y %H:%M:%S",
                                   tz = "UTC"))

usethis::use_data(calcofi_ctd, overwrite = TRUE)

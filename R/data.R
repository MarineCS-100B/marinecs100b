#' CalCOFI CTD data
#'
#' A subset of CTD casts from CalCOFI cruise 1708SR (July 2017). Uses the "Final
#' 1m-Binned" data. Only four stations' downcasts are included. Those stations
#' are 083.3 070.0, 083.3 110.0, 090.0 070.0, and 090.0 110.0.
#'
#' @format `calcofi_ctd` A data frame with 2058 rows and 7 columns:
#' \describe{
#'   \item{station_id}{Station ID}
#'   \item{depth, temperature, salinity}{CTD readings. Depth in m, temperature in degC, salinity in PSU}
#'   \item{datetime_utc, longitude, latitude}{Time and location of CTD reading.}
#' }
#' @source <https://calcofi.org/data/oceanographic-data/ctd-cast-files>
"calcofi_ctd"

#' RREAS survey and Commun Murre diet data
#'
#' Two independent proxies for forage fish abundance in the California Current.
#' (1) Log-transformed estimates of catch per unit effort of young-of-the-year
#' rockfish and anchovy from the Rockfish Recruitment Ecosystem Assessment
#' Survey. (2) Percentage of Common Murre diet composed of the same two species
#' observed on Southeast Farallon Island. Rockfish data spans 1983-2019, anchovy
#' 1990-2019.
#'
#' @format `rreas_comu` A data frame with 37 rows and 5 columns:
#' \describe{
#'   \item{year}{Year of data}
#'   \item{comu_yoyrockfish, comu_anchovy}{Fraction of Common Murre diet
#'   composed of young-of-the-year rockfish and anchovy, respectively.}
#'   \item{rreas_yoyrockfish, rreas_anchovy}{Log-transformed catch per unit
#'   effort of young-of-the-year rockfish and anchovy, respectively.}
#' }
#' @source
#' \insertRef{Santora_2021}{marinecs100b}
"rreas_comu"

#' California Current Trophic Database
#'
#' Predator diet samples from the California Current Trophic Database, with prey
#' classified as mesopelagic or coastal pelagic.
#'
#' @format `cctd_meso` A data frame with 227605 rows and 9 columns:
#' \describe{
#'   \item{predator_id, predator_common_name, predator_scientific_name}{ID of
#'   individual predator; common name and scientific name of species.}
#'   \item{prey_id, prey_common_name, prey_scientific_name}{ID of individual
#'   prey item; common name and scientific name of species.}
#'   \item{rreas_yoyrockfish, rreas_anchovy}{Log-transformed catch per unit
#'   effort of young-of-the-year rockfish and anchovy, respectively.}
#' }
#' @source \insertRef{Iglesias_2023}{marinecs100b}
"cctd_meso"

#' Kenai Fjords Temperature Readings
#'
#' Temperature readings from five sites in Kenai Fjords 2007-2024.
#'
#' @format `kefj_*` are all vectors of length 1295038.
#'
#' `kefj_temperature` A numeric vector with the temperature readings in Celsius.
#'
#' `kefj_site` A character vector with the name of the site (one of Aialik,
#'   Harris, McCarty, Nuka_Bay, or Nuka_Pass) of the temperature reading.
#'
#' `kefj_datetime` A POSIXct vector with the date and time of the temperature
#'   record.
#'
#' `kefj_tidelevel` A numeric vector with the predicted tide level (meters) at
#'   the time of the temperature reading.
#'
#' `kefj_exposure` A character vector indicating the type of temperature
#'   reading:
#' \describe{
#'  \item{`air`}{The predicted tidal elevation was at least 0.5 m lower than the
#'  tide height at which the logger was deployed}
#'  \item{`transition`}{The predicted tidal elevation was within 0.5 m of the
#'  tide height at which the logger was deployed}
#'  \item{`water`}{The predicted tidal elevation was at least 0.5 m higher than
#'  the tide height at which the logger was deployed}
#'  \item{`air/transition`}{The tidal elevation and tide height do not match the
#'  parameters for air or transition temperature and the temperature reading
#'  does not align with water temperature}
#' }
#'
#' `kefj_season` A five-level factor indicating season, relating to mussel life
#'   history:
#' \describe{
#'  \item{`Late winter`}{January–March, mussel gonad development}
#'  \item{`Spring`}{April–May, spawning and settlement}
#'  \item{`Summer`}{June–July, spawning and early growth}
#'  \item{`Fall`}{August–October, spawning and late growth}
#'  \item{`Early winter`}{November–December, senescence and early gonad
#'  development}
#' }
#'
#' @source
#' \insertRef{USGS_2024}{marinecs100b}
#'
#' @name kefj
"kefj_temperature"

#' @rdname kefj
#' @format NULL
"kefj_site"

#' @rdname kefj
#' @format NULL
"kefj_datetime"

#' @rdname kefj
#' @format NULL
"kefj_tidelevel"

#' @rdname kefj
#' @format NULL
"kefj_exposure"

#' @rdname kefj
#' @format NULL
"kefj_season"

#' World Ocean Atlas data
#'
#' The latest World Ocean Atlas data (as of 2025). Specifically, the statistical
#' mean of temperature for the "averaged decades" climatology at the annual time
#' scale. Pivoted from wide format (as available from NCEI) to long.
#'
#' @format `woa_long` A data frame with 2810255 rows and 4 columns:
#' \describe{
#'   \item{latitude, longitude}{Latitude and longitude in decimal degrees. Longitude in the range -180, 180.}
#'   \item{depth_m}{Depth in meters.}
#'   \item{temp_c}{Water temperature in °C}
#' }
#' @source
#' <https://www.ncei.noaa.gov/access/world-ocean-atlas-2023/bin/woa23.pl>
"woa_long"

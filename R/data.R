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
#'   \item{comu_yoyrockfish, comu_anchovy}{Fraction of Common Murre diet composed of young-of-the-year
#' rockfish and anchovy, respectively.}
#'   \item{rreas_yoyrockfish, rreas_anchovy}{Log-transformed catch per unit effort of young-of-the-year
#' rockfish and anchovy, respectively.}
#' }
#' @source
#' \insertRef{Santora_2021}{marinecs100b}
"rreas_comu"

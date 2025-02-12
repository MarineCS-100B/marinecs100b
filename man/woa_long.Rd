% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{woa_long}
\alias{woa_long}
\title{World Ocean Atlas data (temperature)}
\format{
\code{woa_long} A data frame with 2810255 rows and 4 columns:
\describe{
\item{latitude, longitude}{Latitude and longitude in decimal degrees. Longitude in the range -180, 180.}
\item{depth_m}{Depth in meters.}
\item{temp_c}{Water temperature in °C}
}
}
\source{
\url{https://www.ncei.noaa.gov/access/world-ocean-atlas-2023/bin/woa23.pl}
}
\usage{
woa_long
}
\description{
The latest World Ocean Atlas data (as of 2025). Specifically, the statistical
mean of temperature for the "averaged decades" climatology at the annual time
scale. Pivoted from wide format (as available from NCEI) to long.
}
\keyword{datasets}

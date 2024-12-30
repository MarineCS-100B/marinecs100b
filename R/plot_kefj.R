#' Plot temperature and exposure data from Kenai Fjords
#'
#' @param datetimes `[POSIXct]` Vector of temperature readings' datetimes
#' @param temperatures `[numeric]` Vector of temperature readings
#' @param exposures `[character]` Vector of temperature logger exposure
#'
#' The lengths of the three vectors must be equal.
#'
#' @return `[ggplot]` A ggplot of the temperature readings, shaded by logger
#'   exposure.
#' @export
plot_kefj <- function(datetimes,
                      temperatures,
                      exposures) {
  # Validate inputs
  stopifnot(inherits(datetimes, "POSIXct"),
            is.numeric(temperatures),
            is.character(exposures),
            all.equal(length(datetimes),
                      length(temperatures),
                      length(exposures)))

  # Combine inputs into data frame
  kefj_df <- data.frame(datetimes,
                        temperatures,
                        exposures)

  # Use run-length encoding to get start and ends of exposure phases
  exposure_rle <- rle(exposures)
  exposure_idx <- cumsum(c(1, head(exposure_rle$lengths, -1)))
  exposure_begin <- datetimes[exposure_idx]
  exposure_end <- c(exposure_begin[-1], exposure_begin[length(exposure_begin)])
  exposure_df <- data.frame(exposure = exposure_rle$values,
                            exposure_begin,
                            exposure_end)

  # Create figure
  ggplot(kefj_df) +
    geom_rect(aes(xmin = exposure_begin, xmax = exposure_end,
                  ymin = -Inf, ymax = Inf,
                  fill = exposure),
              exposure_df,
              alpha = 0.25) +
    geom_line(aes(datetimes, temperatures), linewidth = 1.5) +
    scale_fill_manual(values = c(
      "air" = "#FDFD9A",
      "air/transition" = "#E67D47",
      "transition" = "#95C674",
      "water" = "#7E9CD3"
    )) +
    labs(y = "Temperature (°C)") +
    theme_bw(14) +
    theme(axis.title.x = element_blank())
}

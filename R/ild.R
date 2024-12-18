#' Plot the isothermal layer depth
#'
#' Creates a plot of temperature over depth, highlighting the landmarks needed
#' to calculate isothermal layer depth (ILD) according to the methods of Kara et
#' al. (2000).
#'
#' @param cast `[data.frame]` A data.frame with the CTD cast data, containing
#'   columns `temperature` and `depth`.
#' @param n `[numeric(1)]` The index of the last CTD point above the base of the
#'   ILD.
#' @param h_b `[numeric(1)]` The depth of the ILD base.
#' @param t_b `[numeric(1)]` The temperature of the ILD base.
#' @param h_ref `[numeric(1)]` The depth of the ILD reference temperature.
#' @param t_ref `[numeric(1)]` The ILD reference temperature.
#'
#' @return `[ggplot]` A ggplot of the CTD cast in the isothermal layer, with
#'   landmarks labeled.
#' @export
#'
#' @references
#' \insertRef{Kara_2000}{marinecs100b}
#'
#' @examples
#' # You (the student) will calculate these values in one of the modules!
#' n <- 22
#' h_b <- 23.83
#' t_b <- 16.41
#' h_ref <- 19
#' t_ref <- 17.21
#' cast <- calcofi_ctd[calcofi_ctd$station_id == "083.3 070.0", ]
#' plot_ild(cast, n, h_b, t_b, h_ref, t_ref)
plot_ild <- function(cast, n, h_b, t_b, h_ref, t_ref) {
  # Determine expanded temperature limits to accommodate text annotations
  t_n2 <- cast$temperature[n + 2]
  t_lim <- range(cast$temperature[1:(n + 2)])
  t_lim[1] <- t_lim[1] - 0.15 * (t_lim[2] - t_lim[1])

  # Extract landmarks from ILD
  h_n <- cast$depth[n]
  h_n1 <- cast$depth[n + 1]
  t_n <- cast$temperature[n]
  t_n1 <- cast$temperature[n + 1]

  # Plot ILD part of cast
  ild_cast <- cast[1:(n + 2), ]
  ggplot(ild_cast, aes(temperature, depth)) +
    geom_path() +
    geom_point() +
    geom_hline(yintercept = h_ref, linetype = "dashed") +
    geom_hline(yintercept = c(h_n, h_n1), linetype = "dotted") +
    annotate("text",
             x = t_lim[1],
             y = c(h_ref, h_n, h_n1),
             label = c("h[ref]", "h[n]", "h[n+1]"),
             hjust = 0, vjust = -0.1, size = 5, parse = TRUE) +
    annotate("text",
             x = c(t_ref, t_n, t_n1, t_b),
             y = c(h_ref, h_n, h_n1, h_b),
             label = c("T[ref]", "T[n]", "T[n+1]", "T[b]"),
             hjust = 1.2, vjust = -0.1, size = 5, parse = TRUE) +
    annotate("point", t_b, h_b, shape = 21, fill = "white") +
    annotate("segment",
             x = t_b, xend = t_ref,
             y = h_b + 0.5, yend = h_b + 0.5,
             arrow = arrow(angle = 90, length = unit(1, "mm"), ends = "both")) +
    annotate("text",
             x = mean(c(t_b, t_ref)), y = h_b + 0.5,
             label = "Delta * T", vjust = -0.15, parse = TRUE) +
    annotate("segment",
             x = t_lim[2] + 0.05, xend = t_lim[2] + 0.05,
             y = 0, yend = h_b,
             arrow = arrow(angle = 90, length = unit(1, "mm"), ends = "both")) +
    annotate("text",
             x = t_lim[2] + 0.05, y = h_b / 2,
             label = "h[L](T)", hjust = -0.1, parse = TRUE) +
    scale_y_reverse() +
    xlim(t_lim[1], t_lim[2] + 0.1) +
    labs(x = expression("Temperature (" * degree * "C)"),
         y = "Depth (m)") +
    coord_cartesian(ylim = c(h_n1 - 0.5, 0)) +
    theme_bw(14)
}

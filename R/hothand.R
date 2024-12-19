#' Plot the results of "hot hand" simulations
#'
#' @param sim_results `[numeric(n)]` A vector with post-streak chomp-rates for
#'   multiple simulations with the same simulation parameters.
#' @param trend_results `[data.frame]` A data frame with columns
#'   `chomp_attempts`, `chomp_rate`, and `streak_rate`. Each row represents the
#'   results from a single hot hand simulation. The simulation parameters for
#'   each row are described by columns `chomp_attempts` and `chomp_rate`.
#'
#' @return `[ggplot]` A ggplot of:
#'
#'   * `plot_hothand_trends()`: the mean "post-streak" chomp rate (solid lines)
#'   over chomp attempts (dashed lines) for different independent chomp rates.
#'
#'   * `plot_hothand_simulation()`: a histogram of "post-streak" chomp rates
#'   with the mean simulated rate represented by a solid red line and the
#'   independent chomp rate indicated by a dashed red line.
#'
#' @name hothand
NULL

#' @rdname hothand
#' @export
plot_hothand_simulation <- function(sim_results) {
  stopifnot(is.numeric(sim_results), is.vector(sim_results))
  ggplot(data.frame(Rate = sim_results)) +
    geom_histogram(aes(Rate), fill = "cornflowerblue") +
    geom_vline(xintercept = 0.8,
               color = "firebrick",
               linetype = "dashed",
               linewidth = 1.5) +
    geom_vline(xintercept = mean(sim_results, na.rm = TRUE),
               color = "firebrick",
               linewidth = 1.5) +
    theme_classic(14)
}

#' @rdname hothand
#' @export
plot_hothand_trends <- function(trend_results) {
  stopifnot(
    is.data.frame(trend_results),
    all(c("chomp_attempts", "chomp_rate", "streak_rate") %in% names(trend_results))
  )
  result_summ <- trend_results |>
    dplyr::group_by(chomp_attempts, chomp_rate) |>
    dplyr::summarize(streak_rate = mean(streak_rate, na.rm = TRUE),
                     .groups = "drop")
  ggplot(result_summ, aes(chomp_attempts, streak_rate)) +
    geom_line(aes(group = chomp_rate), linewidth = 1.25, color = "firebrick") +
    geom_hline(yintercept = unique(result_summ$chomp_rate),
               linetype = "dashed",
               color = "cornflowerblue",
               linewidth = 1.25) +
    scale_x_continuous("Chomp attempts", limits = c(0, NA)) +
    scale_y_continuous("Chomp post-streak",
                       limits = c(0, 1),
                       labels = scales::label_percent()) +
    theme_classic(14)
}

hot_hand <- function(chomp_rate, chomp_attempts) {
  chomp_history <- rbinom(chomp_attempts, 1, chomp_rate)

  streak_threshold <- 3
  streak_chomp <- 0
  streak_miss <- 0
  for (i in (streak_threshold + 1):chomp_attempts) {
    previous_attempts <- chomp_history[(i - streak_threshold):(i - 1)]
    this_attempt <- chomp_history[i]
    if (all(previous_attempts == 1)) {
      if (this_attempt == 1) {
        streak_chomp <- streak_chomp + 1
      } else {
        streak_miss <- streak_miss + 1
      }
    }
  }
  if (streak_chomp + streak_miss > 0) {
    result <- streak_chomp / (streak_chomp + streak_miss)
  } else {
    result <- NA
  }
  result
}

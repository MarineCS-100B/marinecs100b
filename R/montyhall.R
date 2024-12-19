#' Plot the results of two different Monty Hall strategies
#'
#' @param n_trials `[numeric(1)]` The number of trials simulated.
#' @param stayput_success `[numeric(1)]` The number of success from strategy
#'   "stay put".
#' @param switch_success `[numeric(1)]` The number of success from strategy
#'   "switch".
#'
#' @return `[ggplot]` A ggplot of a bar plot showing the differences in success
#'   between the two strategies.
#' @export
#'
#' @examples
#' # Note: your results will look very different if you simulated the two
#' # strategies correctly!
#' plot_montyhall(1000, 500, 500)
plot_montyhall <- function(n_trials, stayput_success, switch_success) {
  stopifnot(
    is.numeric(stayput_success) && length(stayput_success) == 1,
    is.numeric(switch_success) && length(switch_success) == 1,
    is.numeric(n_trials) && length(n_trials) == 1
  )
  ggplot(data.frame(Strategy = c("Stay put", "Switch"),
                    Successes = c(stayput_success, switch_success))) +
    geom_col(aes(x = Strategy, y = Successes)) +
    ylim(c(0, n_trials)) +
    theme_classic(14)
}

montyhall_stayput <- function() {
  buckets <- 1:3
  # Fish is in bucket 1, 2, or 3
  fish <- sample(buckets, 1)
  # You choose bucket 1, 2, or 3
  choice1 <- sample(buckets, 1)
  # Fisher eliminates one of the other two options
  if (fish == choice1) {
    eliminate <- sample(buckets[-fish], 1)
  } else {
    eliminate <- buckets[-c(fish, choice1)]
  }
  remaining <- buckets[-eliminate]
  # Stay put strategy
  choice2 <- choice1
  # Did it work?
  choice2 == fish
}

montyhall_switch <- function() {
  buckets <- 1:3
  # Fish is in bucket 1, 2, or 3
  fish <- sample(buckets, 1)
  # You choose bucket 1, 2, or 3
  choice1 <- sample(buckets, 1)
  # Fisher eliminates one of the other two options
  if (fish == choice1) {
    eliminate <- sample(buckets[-fish], 1)
  } else {
    eliminate <- buckets[-c(fish, choice1)]
  }
  remaining <- buckets[-eliminate]
  # Stay put strategy
  choice2 <- remaining[remaining != choice1]
  # Did it work?
  choice2 == fish
}

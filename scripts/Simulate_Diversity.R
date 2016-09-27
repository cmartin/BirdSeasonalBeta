rm(list = ls())
library(rebird)
library(vegan)
library(purrr)

data(state)

simulate_diversity_for_state <- function(state_code) {
  res <- ebirdfreq("states",paste0("US-",state_code), long = FALSE)

  freqs <- as.matrix(
    res[-1,-1]
  )

  colnames(freqs) <- colnames(res)[-1]
  rownames(freqs) <- res$comName[-1]

  sim_obs <- t(matrix(
    data = rbinom(length(freqs),8,freqs),
    ncol = ncol(freqs),
    nrow = nrow(freqs),
    dimnames = list(rownames(freqs), colnames(freqs))
  ))

  alpha <- mean(specnumber(sim_obs))
  gamma <- specnumber(sim_obs, c(1))
  list(
    alpha = alpha,
    gamma = as.numeric(gamma),
    beta = gamma / alpha,
    absolute_turnover = gamma - alpha,
    whittaker = gamma / alpha - 1,
    proportional = 1 - alpha / gamma
  )

}

res <- map_df(state.abb,simulate_diversity_for_state)

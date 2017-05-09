library(tidyverse)
library(rebird)
library(vegan)
library(purrr)
library(stringr)
library(memoise)

source("lib/EBird_Tools.R")

data(state)

simulate_diversity_for_state <- function(
  state_code,
  n_checklists_per_week = 8,
  replicate_number = 1
) {

  freqs <- calculate_frequencies(state_code)

  sim_obs <- t(matrix(
    data = rbinom(length(freqs),n_checklists_per_week,freqs),
    ncol = ncol(freqs),
    nrow = nrow(freqs),
    dimnames = list(rownames(freqs), colnames(freqs))
  ))

  alpha <- mean(specnumber(sim_obs))
  gamma <- specnumber(sim_obs, c(1))
  list(
    location = paste0("US-",state_code),
    alpha = alpha,
    gamma = as.numeric(gamma),
    beta = gamma / alpha,
    absolute_turnover = gamma - alpha,
    whittaker = gamma / alpha - 1,
    proportional = 1 - alpha / gamma,
    var_alpha = var(specnumber(sim_obs)),
    n_checklists_per_week = n_checklists_per_week,
    replicate_number = replicate_number
  )

}

res <- pmap_df(
  expand.grid(
    state_code = state.abb,
    n_checklists_per_week = c(2,8,32,128,512,2048),
    replicate_number = 1:20,
    stringsAsFactors = FALSE
  ),
  simulate_diversity_for_state
)

write_csv(res, "data/Simulation_Results.csv")

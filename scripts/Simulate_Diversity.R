rm(list = ls())
library(rebird)
library(vegan)
library(purrr)
library(stringr)
library(memoise)
library(readr)

source("lib/CleanFreqs.R")

data(state)

# Cache ebird data locally for faster simulations
m_ebird_freqs <- memoise(
  ebirdfreq,
  cache = cache_filesystem("cache/freqs")
)

simulate_diversity_for_state <- function(
  state_code,
  country_code = "US",
  n_checklists_per_week = 8,
  replicate_number = 1
) {

  location <- paste0(country_code,"-",state_code)
  res <- m_ebird_freqs("states",location, long = FALSE)
  freqs <- clean_freqs(res)

  sim_obs <- t(matrix(
    data = rbinom(length(freqs),n_checklists_per_week,freqs),
    ncol = ncol(freqs),
    nrow = nrow(freqs),
    dimnames = list(rownames(freqs), colnames(freqs))
  ))

  alpha <- mean(specnumber(sim_obs))
  gamma <- specnumber(sim_obs, c(1))
  list(
    location = location,
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

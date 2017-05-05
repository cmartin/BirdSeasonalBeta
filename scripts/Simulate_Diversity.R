rm(list = ls())
library(rebird)
library(vegan)
library(purrr)
library(stringr)
library(memoise)

data(state)

# Cache ebird data locally for faster simulations
m_ebird_freqs <- memoise(
  ebirdfreq,
  cache = cache_filesystem("cache/freqs")
)

simulate_diversity_for_state <- function(
  state_code,
  country_code = "US",
  n_checklists_per_week = 8
) {

  location <- paste0(country_code,"-",state_code)
  res <- m_ebird_freqs("states",location, long = FALSE)

  freqs <- as.matrix(
    res[-1,-1]
  )

  colnames(freqs) <- colnames(res)[-1]
  rownames(freqs) <- res$comName[-1]

  to_remove <- "sp\\.|/|domestic|hybrid|Domestic"

  sp_names <- rownames(freqs)

  freqs <- freqs[!str_detect(sp_names,to_remove),]

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
    var_alpha = var(specnumber(sim_obs))
  )

}

res <- map_df(state.abb,simulate_diversity_for_state)

save(res,file = "data/US_Diversity.RData")

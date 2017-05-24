library(tidyverse)
library(memoise)
library(rebird)
library(stringr)
library(vegan)
library(betapart)

source("lib/EBird_Tools.R")
source("lib/Monthly_Climate.R")
source("lib/Horn.R")

distances <- map_df(
  state.abb,
  function(x) {
    f <- calculate_frequencies(x)
    n <- ncol(f)
    d <- c(rep(NA,n - 1))
    for (i in 1:(n - 1)) {
      d[i] <- 1 - horn2(f[,i],f[,i + 1])
    }

    b <- bray.part(t(f))



    list(
      horn = mean(d),
      bray = mean(diag(as.matrix(b$bray)[-1,])),
      turnover = mean(diag(as.matrix(b$bray.bal)[-1,])),
      nestedness = mean(diag(as.matrix(b$bray.gra)[-1,])),
      location = x,
      alpha = mean(specnumber(t(f))),
      gamma = as.numeric(specnumber(t(f),1))
    )
  }
)

# Adding the proportion of resident species in each state
distances <- distances %>%
  merge(
    map_df(
      state.abb,
      calculate_species_frequencies
    ) %>%
      group_by(location) %>%
      summarise(prop_resident = sum(frequency == 1) / n()) %>%
      arrange(prop_resident)
  )

# Add meta-data about states
distances <- distances %>%
  merge(
    tibble(
      location = state.abb,
      region = str_to_lower(state.name),
      state_area = state.area * 2.58999, # square mile to km,
      log_state_area = log(state_area),
      latitude = state.center$y,
      longitude = state.center$x
    )
  )

# Fetch climate data about states
distances <- distances %>%
  mutate(
    longitude = ifelse(location == "DE",-75.2,longitude), # nudge delaware at bit out of the ocean
    jan_temp = monthly_climate_at_point(
      lat = latitude,
      lon = longitude,
      mon = 1,
      var = "tmean",
      res = 10
    ),
    jul_temp = monthly_climate_at_point(
      lat = latitude,
      lon = longitude,
      mon = 7,
      var = "tmean",
      res = 10
    ),
    temp_range = jul_temp - jan_temp
  )

write_csv(distances,"data/distances.csv")

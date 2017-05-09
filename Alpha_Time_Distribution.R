library(tidyverse)
library(memoise)
library(rebird)
library(stringr)
library(vegan)
source("lib/EBird_Tools.R")

data(state)

weekly_richness <- function(location) {
  freqs <- calculate_frequencies(location)
  s <- specnumber(t(freqs))
  tibble(
    location = location,
    alpha = as.numeric(s),
    week_name = names(s),
    week = 1:48
  )
}

res <- map_df(
  state.abb[!state.abb %in% c("HI", "AK")],
  weekly_richness
)

res %>%
  ggplot(aes(x = week, y = alpha)) +
  geom_line(aes(color = location))

res %>%
  group_by(location) %>%
  mutate(rel_alpha = alpha / max(alpha)) %>%
  ggplot(aes(x = week, y = rel_alpha)) +
  geom_line(aes(color = location))

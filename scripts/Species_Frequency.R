library(tidyverse)
library(memoise)
library(rebird)
library(stringr)
library(purrr)
source("lib/EBird_Tools.R")

data(state)

freqs <- map_df(
  state.abb[!state.abb %in% c("HI", "AK")],
  calculate_species_frequencies
)

freqs %>%
  group_by(location) %>%
  summarise(prop_resident = sum(frequency == 1) / n()) %>%
  arrange(prop_resident)

freqs %>%
  group_by(location) %>%
  mutate(rank = row_number(desc(frequency))) %>%
  ungroup() %>%
  ggplot(aes(x = rank, y = frequency)) +
  geom_line(color = "royalblue") +
  facet_wrap(~location, nrow = 8) +
  theme_minimal()

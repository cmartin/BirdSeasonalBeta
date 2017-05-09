library(tidyverse)
library(memoise)
library(rebird)
library(stringr)
library(purrr)
source("lib/CleanFreqs.R")

data(state)

m_ebird_freqs <- memoise(
  ebirdfreq,
  cache = cache_filesystem("cache/freqs")
)

calculate_frequencies <- function(location) {
  res <- m_ebird_freqs("states",paste0("US-",location), long = FALSE)
  freqs <- clean_freqs(res)
  tibble(
    species = rownames(freqs),
    frequency = as.numeric(rowSums(freqs > 0)/48),
    location = location
  )

}

freqs <- map_df(
  state.abb[!state.abb %in% c("HI", "AK")],
  calculate_frequencies
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

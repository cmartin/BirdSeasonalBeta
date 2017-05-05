library(tidyverse)
library(stringr)
load("data/US_Diversity.RData")

res %>%
  group_by(n_checklists_per_week) %>%
  mutate(location = str_replace(location,"US-","")) %>%
  arrange(desc(beta)) %>%
  mutate(rank = row_number()) %>%
  ungroup %>%
  ggplot(aes(x = n_checklists_per_week^.25, y = rank)) +
  geom_line(aes(color = location)) +
  scale_y_reverse() +
  scale_x_continuous(
    breaks = unique(res$n_checklists_per_week)^.25,
    labels = unique(res$n_checklists_per_week)
  ) +
  labs(
    x = "Simulated checklists per week",
    y = "Beta diversity rank",
    color = "US State"
  ) +
  theme_minimal()

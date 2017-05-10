library(tidyverse)
distances <- read_csv("data/distances.csv")

distances %>%
  gather(
    key = var,
    value = value,
    prop_resident, log_state_area:temp_range
  ) %>%
  ggplot(aes(x = value,y = d)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~var, scales = "free_x")

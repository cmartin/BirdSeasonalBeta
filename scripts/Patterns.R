library(tidyverse)
distances <- read_csv("data/distances.csv")

distances %>%
  gather(
    key = var,
    value = value,
    alpha, gamma, prop_resident, log_state_area:temp_range
  ) %>%
  ggplot(aes(x = value,y = d)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~var, scales = "free_x")

db <- distances %>%
  dplyr::select(alpha, gamma, prop_resident, log_state_area:temp_range) %>%
  filter(complete.cases(.))

cor(
  db,
  method = "spearman"
)

pca <- prcomp(db,
              scale = TRUE)
biplot(pca)

# Exploring beta diversity components
library(tidyverse)
distances <- read_csv("data/distances.csv")

# Bray-Curtis and Horn dissimilarity are mostly the same
distances %>%
  ggplot(aes(x = horn, y = bray)) +
  geom_point()
cor(distances$horn, distances$bray)

# In our dataset, turnover and nestedness are moderately correlated
distances %>%
  ggplot(aes(x = turnover, y = nestedness)) +
  geom_point()
cor(distances$turnover,distances$nestedness)

db <- distances %>%
  gather(key = part, value = value, turnover, nestedness)

# Components don't change differently in the latitude gradient
db %>%
  ggplot(aes(y = value, x = latitude)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~part, scales = "free_y")

summary(step(lm(value~part*latitude,data = db)))

# And relationships to the independent vars are very close to those of the Horn dissimilarity
distances %>%
  gather(key = part, value = div, turnover, nestedness) %>%
  gather(key = explanatory_var, value = value, gamma, temp_range) %>%
  ggplot(aes(x = value,y = div)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y~poly(x,2)) +
  facet_grid(part~explanatory_var, scales = "free")


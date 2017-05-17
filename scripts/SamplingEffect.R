library(tidyverse)
distances <- read_csv("data/distances.csv") %>% filter(complete.cases(.))

db <- distances %>%
  gather(key = metric, value = diversity, alpha, gamma)

db %>%
  ggplot(aes(x = latitude, y = diversity, col = metric, shape = metric)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal() +
  labs(x = "Latitude", y = "Diversity") +
  guides(color = "none", shape = "none") +
  scale_color_manual(values = c("alpha" = "tomato", "gamma" = "royalblue"))

m <- lm(diversity~latitude*metric, data = db)
summary(
  m
)

summary(
  lm(diversity~latitude+metric, data = db)
)

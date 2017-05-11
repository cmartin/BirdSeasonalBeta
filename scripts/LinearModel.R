library(tidyverse)
library(modelr)
library(MASS)

distances <- read_csv("data/distances.csv") %>% filter(complete.cases(.))


m <- lm(d~gamma+I(gamma^2)+temp_range+I(temp_range^2), data = distances)
summary(m)

m2 <- stepAIC(m)

summary(m2)

distances <- distances %>%
  add_residuals(m2) %>%
  mutate(
    gamma_effect = resid + gamma * coef(m2)["gamma"],
    temp_range_effect = resid + temp_range * coef(m2)["temp_range"] + (temp_range^2) * coef(m2)["I(temp_range^2)"]
  )

distances %>%
  ggplot(aes(x = resid)) +
  geom_histogram(bins = 12)

p1 <- distances %>%
  ggplot(aes(x = gamma,y = gamma_effect)) +
  geom_point(size = 2) +
  geom_line(aes(y = gamma_effect - resid), col = "royalblue") +
  theme_minimal() +
  labs(y = "Change in beta diversity", x = "Size of the species pool")

p2 <- distances %>%
  ggplot(aes(x = temp_range,y = temp_range_effect)) +
  geom_point(size = 2) +
  geom_line(aes(y = temp_range_effect - resid), col = "royalblue") +
  theme_minimal() +
  labs(y = NULL, x = "Annual variation of\nair temperature")

library(gridExtra)
grid.arrange(p1, p2, ncol = 2)

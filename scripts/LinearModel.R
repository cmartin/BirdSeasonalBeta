library(tidyverse)
library(modelr)
library(MuMIn)
library(vegan)

distances <- read_csv("data/distances.csv") %>% filter(complete.cases(.))


m <- lm(d~gamma+I(gamma^2)+temp_range+I(temp_range^2), data = distances)
summary(m)

options(na.action = "na.fail")
d <- dredge(m, subset = dc(gamma, I(gamma^2)) + dc(temp_range,I(temp_range^2)))
d
importance(d)

# Best model is without gamma^2
m2 <- lm(d~gamma+temp_range+I(temp_range^2), data = distances)
summary(m2)

sum(cooks.distance(m2) > 2)

distances <- distances %>%
  add_residuals(m2) %>%
  add_predictions(m2) %>%
  mutate(
    gamma_effect = resid + gamma * coef(m2)["gamma"],
    temp_range_effect = resid + temp_range * coef(m2)["temp_range"] + (temp_range^2) * coef(m2)["I(temp_range^2)"]
  )

distances %>%
  ggplot(aes(x = resid)) +
  geom_histogram(bins = 12)

distances %>%
  ggplot(aes(x = pred, y = resid)) +
  geom_point() +
  geom_smooth()

p2 <- distances %>%
  ggplot(aes(x = gamma,y = gamma_effect)) +
  geom_point(size = 3) +
  geom_line(aes(y = gamma_effect - resid), col = "royalblue") +
  theme_minimal() +
  labs(y = "Change in seasonal\nbeta-diversity", x = "Size of the species pool") +
  ggtitle("(b)") + theme(plot.title = element_text(hjust = -0.45, vjust = -0))

p1 <- distances %>%
  ggplot(aes(x = temp_range,y = temp_range_effect)) +
  geom_point(size = 3) +
  geom_line(aes(y = temp_range_effect - resid), col = "royalblue") +
  theme_minimal() +
  labs(y = "Change in seasonal\nbeta-diversity", x = "Annual temperature range") +
  ggtitle("(a)") + theme(plot.title = element_text(hjust = -0.45, vjust = 0))

library(gridExtra)
g <- arrangeGrob(p1, p2, nrow = 2)
ggsave("results/Fig1.eps", g, width = 3, height = 4.5)

# How is variance seperated between these components
varpart(
  distances$d,
  ~gamma+I(gamma^2),
  ~temp_range,
  data = distances
)

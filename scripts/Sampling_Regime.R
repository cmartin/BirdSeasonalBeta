library(tidyverse)
library(stringr)

res <- read_csv("data/Simulation_Results.csv") %>%
  filter(!(location %in% c("US-HI", "US-AK")))

se <- function(x) {
  sd(x)/sqrt(length(x))
}

View(
res %>%
  group_by(location, n_checklists_per_week) %>%
  summarise_each(
    funs(mean,se),
    alpha,
    beta,
    gamma
  )
)

ranks <- res %>%
  group_by(location, n_checklists_per_week) %>%
  summarise_each(
    funs(mean),
    alpha,
    beta,
    gamma
  ) %>%
  ungroup() %>%
  mutate(location = str_replace(location,"US-","")) %>%
  gather(key = "diversity_metric", value = "value", alpha,gamma,beta) %>%
  group_by(n_checklists_per_week,diversity_metric) %>%
  arrange(desc(value)) %>%
  mutate(rank = row_number()) %>%
  ungroup

ranks %>%
  ggplot(aes(x = as.numeric(as.factor(n_checklists_per_week)), y = rank)) +
  geom_line(aes(color = location), size = 1) +
  scale_y_reverse() +
  scale_x_continuous(
    breaks = as.numeric(as.factor(unique(res$n_checklists_per_week))),
    labels = unique(res$n_checklists_per_week)
  ) +
  labs(
    x = "Simulated checklists per week",
    y = "Rank",
    color = "US State"
  ) +
  theme_minimal() +
  facet_wrap(~diversity_metric) +
  theme(legend.position = "bottom") +
  guides(color = guide_legend(nrow = 3))

rank_table <- ranks %>%
  select(location, n_checklists_per_week, diversity_metric, rank) %>%
  filter(diversity_metric == "beta") %>%
  spread(key = n_checklists_per_week, value = rank)

View(
  rank_table
)

rank_table %>% select(`2`:`2048`) %>% cor

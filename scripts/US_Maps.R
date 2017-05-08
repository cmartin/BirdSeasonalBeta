# vs http://www.biodiversitymapping.org/USA_birds.htm#thumb

# https://gist.github.com/cdesante/4252133

# devtools::install_github("baptiste/egg")

library(tidyverse)
library(stringr)
library(purrr)
library(egg)

#load("data/US_Diversity.RData")
res <- read_csv("data/Simulation_Results.csv") %>%
  group_by(location, n_checklists_per_week) %>%
  summarise_each(
    funs(mean),
    alpha,
    beta,
    gamma
  ) %>%
  ungroup() %>%
  filter(n_checklists_per_week == 8)

all_states <- map_data("state")
res$region <- str_to_lower(state.name)

all_states <- all_states[all_states$region != "district of columbia",]

Total <- merge(all_states, res, by = "region")

plots <- pmap(list(
  div_var = c("alpha","gamma", "beta"),
  fig_name_suffix = c("a","b","c"),
  high_color = c("darkred", "darkgreen", "darkblue")
),function(div_var,fig_name_suffix,high_color) {
  ggplot() +
    geom_polygon(
    data = Total,
    aes(x = long, y = lat, group = group, fill = Total[,div_var]),
    colour = "white") +
    scale_fill_continuous(low = "thistle2", high = high_color, guide = "colorbar") +
    theme_bw() +
    labs(fill = str_to_title(div_var), x = "", y = "") +
    scale_y_continuous(breaks = c()) +
    scale_x_continuous(breaks = c()) +
    theme(panel.border = element_blank()) +
    ggtitle(fig_name_suffix) + theme(plot.title = element_text(hjust = 0))
}
)

combined_plots <- ggarrange(
  plots[[1]],plots[[2]], plots[[3]],
  ncol = 1
)
ggsave(paste0("results/Fig1.eps"), combined_plots, width = 0.66*8, height = 0.33*11*3)

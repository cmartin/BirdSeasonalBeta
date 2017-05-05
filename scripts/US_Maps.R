# vs http://www.biodiversitymapping.org/USA_birds.htm#thumb

# https://gist.github.com/cdesante/4252133

rm(list = ls())
library(stringr)
library(ggplot2)
library(purrr)

load("data/US_Diversity.RData")

all_states <- map_data("state")
res$region <- str_to_lower(state.name)

all_states <- all_states[all_states$region != "district of columbia",]

Total <- merge(all_states, res, by = "region")

pwalk(list(
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

  ggsave(paste0("results/Fig1", fig_name_suffix ,".eps"), width = 0.66*8, height = 0.33*11)

}
)

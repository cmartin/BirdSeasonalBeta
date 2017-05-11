library(tidyverse)
distances <- read_csv("data/distances.csv")

### Fig. 1
Total <- merge(
  map_data("state"),
  distances
) %>% arrange(order)

ggplot(Total) +
  geom_polygon(
    aes(x = long, y = lat, group = group, fill = d),
    colour = "white"
  ) +
  scale_fill_continuous(low = "thistle2", high = "royalblue4", guide = "colorbar") +
  theme_bw() +
  labs(fill = "Beta\ndiversity", x = "", y = "") +
  scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank()) +
  theme(plot.title = element_text(hjust = 0))

ggsave(paste0("results/Fig1.eps"), width = .66*8.5, height = 3.5)

library(tidyverse)
library(egg)

distances <- read_csv("data/distances.csv")

### Fig. 1
Total <- merge(
  map_data("state"),
  distances
) %>% arrange(order)

p3 <- ggplot(Total) +
  geom_polygon(
    aes(x = long, y = lat, group = group, fill = d),
    colour = "white"
  ) +
  scale_fill_continuous(low = "thistle2", high = "darkgreen", guide = "colorbar") +
  theme_bw() +
  labs(fill = "", x = "", y = "") +
  scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank())

ggsave(paste0("results/Fig2.eps"), p3, width = 0.75*8, height = 0.33*11)


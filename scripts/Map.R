library(tidyverse)
library(egg)

distances <- read_csv("data/distances.csv")

### Fig. 1
Total <- merge(
  map_data("state"),
  distances
) %>% arrange(order)

p1 <- ggplot(Total) +
  geom_polygon(
    aes(x = long, y = lat, group = group, fill = alpha),
    colour = "white"
  ) +
  scale_fill_continuous(low = "thistle2", high = "darkred", guide = "colorbar") +
  theme_bw() +
  labs(fill = "", x = "", y = "") +
  scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank(), legend.text.align = 3) +
  annotate("text", label = "(a)", x = -128, y = 49, vjust = 1, size = 5)

p2 <- ggplot(Total) +
  geom_polygon(
    aes(x = long, y = lat, group = group, fill = temp_range),
    colour = "white"
  ) +
  scale_fill_continuous(low = "thistle2", high = "darkblue", guide = "colorbar") +
  theme_bw() +
  labs(fill = "", x = "", y = "") +
  scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank()) +
  annotate("text", label = "(b)", x = -128, y = 49, vjust = 1, size = 5)

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
  theme(panel.border = element_blank()) +
  theme(plot.title = element_text(hjust = 0)) +
  annotate("text", label = "(c)", x = -128, y = 49, vjust = 1, size = 5)


combined_plots <- ggarrange(
  p1,p2,p3,
  ncol = 1
)

ggsave(paste0("results/Fig1.eps"), combined_plots, width = 0.75*8, height = 0.33*11*3)


library(tidyverse)
library(memoise)
library(rebird)
library(stringr)
library(vegan)
source("lib/EBird_Tools.R")

distances <- map_df(
  state.abb,
  function(x) {
    f <- calculate_frequencies(x)

    # Calculate distance matrix
    m <- as.matrix(vegdist(t(f), method = "horn")) # Which is Morista-Horn

    # Extract distance to neighboring-week
    d <- diag(m[-1,])
    #plot(d, type = "l")
    list(
      d = mean(d),
      location = x
    )
  }
)

### Quick map

all_states <- map_data("state")
Total <- merge(
  all_states,
  distances %>%
    merge(
      tibble(
        region = str_to_lower(state.name),
        location = state.abb
      )
    )
) %>% arrange(order)

ggplot(Total) +
  geom_polygon(
    aes(x = long, y = lat, group = group, fill = d),
    colour = "white"
  ) +
  scale_fill_continuous(low = "thistle2", high = "blue", guide = "colorbar") +
  theme_bw() +
  labs(fill = str_to_title("Morisita-Horn"), x = "", y = "") +
  scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank()) +
  theme(plot.title = element_text(hjust = 0))

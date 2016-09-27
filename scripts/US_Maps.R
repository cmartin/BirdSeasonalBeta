rm(list = ls())

# vs http://www.biodiversitymapping.org/USA_birds.htm#thumb

# https://gist.github.com/cdesante/4252133

rm(list = ls())
library(stringr)
library(ggplot2)

load("data/US_Diversity.RData")

all_states <- map_data("state")
res$region <- str_to_lower(state.name)

all_states <- all_states[all_states$region != "district of columbia",]

Total <- merge(all_states, res, by = "region")

p <- ggplot()
p <- p + geom_polygon(
  data = Total,
  aes(x = long, y = lat, group = group, fill = Total$alpha),
  colour = "white"
) +
  scale_fill_continuous(low = "thistle2", high = "darkred", guide = "colorbar")

P1 <- p + theme_bw() + labs(fill = "Alpha diversity"
                             ,title = "Bird diversity in the continental US", x = "", y = "")
P1 + scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank())

#########

p <- ggplot()
p <- p + geom_polygon(
  data = Total,
  aes(x = long, y = lat, group = group, fill = Total$gamma),
  colour = "white"
) +
  scale_fill_continuous(low = "thistle2", high = "darkgreen", guide = "colorbar")

P1 <- p + theme_bw() + labs(fill = "Gamma diversity"
                            ,title = "Bird diversity in the continental US", x = "", y = "")
P1 + scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank())


########

p <- ggplot()
p <- p + geom_polygon(
  data = Total,
  aes(x = long, y = lat, group = group, fill = Total$beta),
  colour = "white"
) +
  scale_fill_continuous(low = "thistle2", high = "darkblue", guide = "colorbar")

P1 <- p + theme_bw() + labs(fill = "Seasonal beta\n diversity"
                            ,title = "Bird diversity in the continental US", x = "", y = "")
P1 + scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank())

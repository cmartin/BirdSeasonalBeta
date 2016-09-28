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

p1 <- ggplot()
p1 <- p1 + geom_polygon(
  data = Total,
  aes(x = long, y = lat, group = group, fill = Total$alpha),
  colour = "white"
) +
  scale_fill_continuous(low = "thistle2", high = "darkred", guide = "colorbar")

p1 <- p1+ theme_bw() + labs(fill = "Alpha"
                            #,title = "Bird diversity in the continental US"
                            ,x = "", y = "")
p1 <- p1 + scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank())

p1 <- p1 + ggtitle('a') + theme(plot.title=element_text(hjust=0))
p1
ggsave("results/Fig1a.eps")

#########

p2 <- ggplot()
p2 <- p2 + geom_polygon(
  data = Total,
  aes(x = long, y = lat, group = group, fill = Total$gamma),
  colour = "white"
) +
  scale_fill_continuous(low = "thistle2", high = "darkgreen", guide = "colorbar")

p2 <- p2 + theme_bw() + labs(fill = "Gamma"
                            #,title = "Bird diversity in the continental US"
                            , x = "", y = "")
p2 <- p2 + scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank())

p2 <- p2 + ggtitle('b') + theme(plot.title=element_text(hjust=0))
p2
ggsave("results/Fig1b.eps")


########

p3 <- ggplot()
p3 <- p3 + geom_polygon(
  data = Total,
  aes(x = long, y = lat, group = group, fill = Total$beta),
  colour = "white"
) +
  scale_fill_continuous(low = "thistle2", high = "darkblue", guide = "colorbar")

p3 <- p3 + theme_bw() + labs(fill = "Beta"
                            #,title = "Bird diversity in the continental US"
                            , x = "", y = "")
p3 <- p3 + scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank())

p3 <- p3 + ggtitle('c') + theme(plot.title=element_text(hjust=0))
p3
ggsave("results/Fig1c.eps")


#######

# source("lib/multiplot.R")
# multiplot(p1, p2, p3, cols = 1)

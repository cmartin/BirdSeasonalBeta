rm(list = ls())

options(tibble.print_max = Inf)

library(maps)
data(state)

load("data/US_Diversity.RData")

range01 <- function(x){(x - min(x))/(max(x) - min(x))}

ramp <- colorRamp(c("white","black"))

names_from_map <- map(database = "state", namesonly=TRUE,plot = FALSE)

map(
  database = "state",
  regions = state.name,
  col = rgb(ramp(range01(res$alpha)), maxColorValue = 255),
  fill = TRUE
)

res[order(res$alpha, decreasing = TRUE),]

# vs http://www.biodiversitymapping.org/USA_birds.htm#thumb

########### Second try, with ggplot this time ############
# https://gist.github.com/cdesante/4252133

rm(list = ls())
library(stringr)
library(ggplot2)

load("data/US_Diversity.RData")

all_states <- map_data("state")
res$region <- str_to_lower(state.name)

Total <- merge(all_states, res, by="region")

Total <- Total[Total$region!="district of columbia",]

p <- ggplot()
p <- p + geom_polygon(data=Total, aes(x=long, y=lat, group = group, fill=Total$alpha),colour="white"
) + scale_fill_continuous(low = "thistle2", high = "darkred", guide="colorbar")
P1 <- p + theme_bw()  + labs(fill = "Scale text"
                             ,title = "Bird diversity map", x="", y="")
P1 + scale_y_continuous(breaks=c()) + scale_x_continuous(breaks=c()) + theme(panel.border =  element_blank())

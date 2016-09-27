rm(list = ls())

options(tibble.print_max = Inf)

library(maps)
data(state)

load("data/US_Diversity.RData")

range01 <- function(x){(x - min(x))/(max(x) - min(x))}

ramp <- colorRamp(c("white","black"))

map(
  database = "state",
  regions = state.name,
  col = rgb(ramp(range01(res$alpha)), maxColorValue = 255),
  fill = TRUE
)

res[order(res$alpha, decreasing = TRUE),]

# vs http://www.biodiversitymapping.org/USA_birds.htm#thumb

rm(list = ls())

library(maps)
data(state)

load("data/US_Diversity.RData")

range01 <- function(x){(x-min(x))/(max(x)-min(x))}

ramp <- colorRamp(c("white","navyblue"))

map(
  database = "state",
  regions = state.name,
  col=rgb(ramp(range01(res$alpha)), maxColorValue = 255),
  fill = TRUE
)

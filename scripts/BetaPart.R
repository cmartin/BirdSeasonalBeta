library(tidyverse)
distances <- read_csv("data/distances.csv")

plot(horn~bray,data = distances)

# Exploring beta diversity components
plot(turnover~nestedness,data = distances)
plot(turnover~latitude,data = distances)
plot(nestedness~latitude,data = distances)
plot(bray~I(turnover+nestedness),data = distances)

plot(turnover~gamma,data = distances)
plot(nestedness~gamma,data = distances)
plot(turnover~temp_range,data = distances)
plot(nestedness~temp_range,data = distances)

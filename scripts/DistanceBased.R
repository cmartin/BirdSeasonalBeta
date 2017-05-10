library(tidyverse)
library(memoise)
library(rebird)
library(stringr)
library(vegan)
source("lib/EBird_Tools.R")
source("lib/Monthly_Climate.R")
source("lib/Horn.R")

distances <- map_df(
  state.abb,
  function(x) {
    f <- calculate_frequencies(x)

    # # Calculate distance matrix
    # m <- as.matrix(vegdist(t(f), method = "horn")) # Which is Morista-Horn
    # # Extract distance to neighboring-week
    # d <- diag(m[-1,])

    n <- ncol(f)
    d <- c(rep(NA,n - 1))
    for (i in 1:(n - 1)) {
      d[i] <- 1 - horn2(f[,i],f[,i + 1])
    }

    #plot(d, type = "l")
    list(
      d = mean(d),
      location = x
    )
  }
)

# Add meta-data about states
distances <- distances %>%
  merge(
    tibble(
      region = str_to_lower(state.name),
      location = state.abb,
      state_area = state.area, # square miles,
      log_state_area = log(state_area),
      latitude = state.center$y,
      longitude = state.center$x
    )
  )

# Fetch climate data about states
distances <- distances %>%
  mutate(
    longitude = ifelse(location == "DE",-75.2,longitude), # nudge delaware at bit out of the ocean
    jan_temp = monthly_climate_at_point(
      lat = latitude,
      lon = longitude,
      mon = 1,
      var = "tmean",
      res = 10
    ),
    jul_temp = monthly_climate_at_point(
      lat = latitude,
      lon = longitude,
      mon = 7,
      var = "tmean",
      res = 10
    ),
    temp_range = jul_temp - jan_temp
  )

### Quick map

all_states <- map_data("state")
Total <- merge(
  all_states,
  distances
) %>% arrange(order)

ggplot(Total) +
  geom_polygon(
    aes(x = long, y = lat, group = group, fill = d),
    colour = "white"
  ) +
  scale_fill_continuous(low = "thistle2", high = "blue", guide = "colorbar") +
  theme_bw() +
  labs(fill = str_to_title("Horn"), x = "", y = "") +
  scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c()) +
  theme(panel.border = element_blank()) +
  theme(plot.title = element_text(hjust = 0))

distances %>%
  gather(
    key = var,
    value = value,
    log_state_area:temp_range
  ) %>%
  ggplot(aes(x = value,y = d)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~var, scales = "free_x")


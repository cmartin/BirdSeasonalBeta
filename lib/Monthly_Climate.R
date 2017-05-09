library(raster)
# http://www.worldclim.org/formats1
monthly_climate_at_point <- function(lat, lon, mon, var = "tmean", res = 0.5) {
  divider <- ifelse(var %in% c("tmean", "tmax", "tmin"), 10, 1)
  w <- getData('worldclim', var = var, res = res, lon = lon, lat = lat)
  r <- raster(w, layer = names(w)[mon])
  extract(r,cellFromXY(r,matrix(c(lon,lat), ncol = 2))) / divider
}

# coldest should be january (1) and hottest july (7)
#monthly_climate_at_point(lat = 46,lon = -72, mon = 1, var = "tmean", res = 10) # 10 minute = about 344 km2 at equator

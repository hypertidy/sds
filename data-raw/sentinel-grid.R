## clean up the unnecessary stuff here
src <- c("https://github.com/maawoo/sentinel-2-grid-geoparquet/raw/refs/heads/main/sentinel-2-grid.parquet",
          "https://github.com/maawoo/sentinel-2-grid-geoparquet/raw/refs/heads/main/sentinel-2-grid_LAND.parquet")
grid <- arrow::read_parquet(src[1])
land <- arrow::read_parquet(src[2])
sum(grid$tile %in% land$tile)
all(land$tile %in% grid$tile)

## land is just a subset of grid
grid$land <- grid$tile %in% land$tile
rm(land)

## they store python code in a column, tuple: `(xmin, ymin, xmax, ymax)`
tx <- read.table(text = gsub(")", "", gsub("\\(", "", grid$utm_bounds)), sep = ",")
grid$xmin <- as.numeric(tx[,1, drop = TRUE])
grid$xmax <- as.numeric(tx[,3, drop = TRUE])
grid$ymin <- as.numeric(tx[,2, drop = TRUE])
grid$ymax <- as.numeric(tx[,4, drop = TRUE])

## zone,latband,lonband (MGRS codes) are mingled in 'tile', epsg is stored as an int
grid$crs <- sprintf("EPSG:%i", grid$epsg)
grid$zone <- substr(grid$tile, 1, 2)
grid$latband <- substr(grid$tile, 3, 3)
grid$lonband <- substr(grid$tile, 4, 5)

grid$geometry <- NULL
grid$epsg <- NULL
grid$utm_bounds <- NULL
grid$utm_wkt <- NULL
grid$tile <- NULL

arrow::write_parquet(grid, "inst/extdata/sentinel_grid.parquet")
sentinel_grid <- grid
usethis::use_data(sentinel_grid)

## create lonlat versions
# l <- split(sentinel_grid, sentinel_grid$zone)
# fun <- function(x) {
#   x <- wk::rct(x$xmin, x$ymin, x$xmax, x$ymax, crs = x$crs[1])
#   geos::geos_
# }
# plot(fun(l[[4]]))

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

## zone,latband,lonband (MGRS codes) are mingled in 'tile', epsg is stored as an int so we make a CRS
## (we can't determine north or south without analysing the epsg, or checking >=N on latband)
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

if (FALSE) {
## create lonlat versions
land <- sentinel_grid[sentinel_grid$land, ]
land$zone_by_hemi <- paste0(land$zone, land$latband < "N")
l <- split(land, land$zone_by_hemi)
box0 <- as.matrix(land[c("xmin", "xmax", "ymin", "ymax")])
## this is way too slow
# ol <- vector("list", nrow(box0))
# for (i in seq_len(nrow(box0))) {
#   ol[[i]] <- reproj::reproj_extent(box0[i, ], target = "EPSG:4326", source = land$crs[i])
# }
# llbox <- do.call(rbind, ol)
#saveRDS(llbox, "data-raw/llbox.rds")
llbox <- readRDS("data-raw/llbox.rds")
fun <- function(x) {
  #print(unique(x$crs))
  out <- wk::rct(x$xmin, x$ymin, x$xmax, x$ymax, crs = x$crs[1])

  out <- geos::geos_densify(out, 100)
  trans <- PROJ::proj_trans_create(x$crs[1], "EPSG:4326")
  wk::wk_transform(out, trans)

}
fun(l[[1]])
trans <- PROJ::proj_trans_create("EPSG:4326", (prj <- "+proj=stere +lat_0=90"))

## all
x_ll <- do.call(c, lapply(l, fun))
iid_ll <- geos::geos_strtree_query(geos::geos_strtree(x_ll), x_ll)
x_xy <- wk::wk_transform(x_ll, trans)
f <- 1e7
plot(NA, xlim = c(-1,1) * f, ylim = c(-1, 1) * f, asp = 1)
plot(sample(x_xy, 10000), add = TRUE)
m <- reproj::reproj_xy(do.call(cbind, maps::map(plot = F)[1:2]), prj, source = "EPSG:4326")
lines(m, col = "hotpink")

tree <- geos::geos_strtree(x_xy)
iid <- geos::geos_strtree_query(tree, x_xy)
plot(x_xy[iid[[1]]])
plot(x_xy[1], add = TRUE, col = "red")
land[iid[[1]], ]
}


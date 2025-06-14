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

l <- vector("list", length(unique(grid$crs)))
for (i  in seq_along(unique(grid$crs))) {

  idx <- unique(grid$crs)[i] == grid$crs
  x <- grid[idx, ]

  xymin <- reproj::reproj_xy(cbind(x$xmin, x$ymin), "EPSG:4326", source = unique(grid$crs)[i])
  xymax <- reproj::reproj_xy(cbind(x$xmax, x$ymax), "EPSG:4326", source = unique(grid$crs)[i])

  bad <- xymax[,1] < xymin[,1]

  xymax[bad, 1] <- xymax[bad, 1] + 360


  x$ll_xmin <- xymin[,1]
  x$ll_ymin <- xymin[,2]
  x$ll_xmax <- xymax[,1]
  x$ll_ymax <- xymax[,2]
  x$antim_wrap <- bad
  l[[i]] <- x
}
grid <- do.call(rbind, l)
vaster::plot_extent(grid[grid$land, c("ll_xmin", "ll_xmax", "ll_ymin", "ll_ymax")])


## redundant on latband but helpful
grid$hemisphere <- c("south", "north")[(grid$latband > "N") + 1L]
grid$geometry <- NULL
grid$epsg <- NULL
grid$utm_bounds <- NULL
grid$utm_wkt <- NULL
grid$tile <- NULL

arrow::write_parquet(grid, "inst/extdata/sentinel_grid.parquet")
sentinel_grid <- grid
usethis::use_data(sentinel_grid, overwrite = T)

if (FALSE) {
  ## create wk objects, if crs is input we unproject (not recommended without care)
  # fun <- function(xmin, xmax, ymin, ymax, crs = NULL, densify = NULL, wrap = FALSE) {
  #   #print(unique(x$crs))
  #   out <- wk::rct(xmin, ymin, xmax, ymax)
  #   if (!is.null(densify)) {
  #     if (densify[1] < 10) stop("densify is < 10 are you sure!!")
  #     out <- geos::geos_densify(out, densify[1])
  #   }
  #   if (!is.null(crs)) {
  #     trans <- PROJ::proj_trans_create(crs[1], "EPSG:4326")
  #     out <- wk::wk_transform(out, trans)
  #     wk::wk_crs(out) <- "EPSG:4326"
  #     if (any(wrap)) {
  #       coords <- wk::wk_coords(out[wrap])
  #       browser()
  #     }
  #   }
  #   out
  # }

  library(dplyr)
## create lonlat versions, and check all the stuff (we now above have sensible xmin,xmax,ymin,ymax and ll_ versions for each that span +180)
# d <-   dplyr::filter(sentinel_grid, land) |>
#     group_by(zone, hemisphere) |>
#     mutate(geometry = fun(xmin, xmax, ymin, ymax, crs[1], wrap = antim_wrap))
# plot(d$geometry)
# allutm <- fun0(land)
# utm_a <- geos::geos_area(allutm)
# range(utm_a)
# sf_a <- sf::st_area(sf::st_as_sf(x_ll))
# range(sf_a)


#box0 <- as.matrix(land[c("xmin", "xmax", "ymin", "ymax")])
## this is way too slow
# ol <- vector("list", nrow(box0))
# for (i in seq_len(nrow(box0))) {
#   ol[[i]] <- reproj::reproj_extent(box0[i, ], target = "EPSG:4326", source = land$crs[i])
# }
# llbox <- do.call(rbind, ol)
#saveRDS(llbox, "data-raw/llbox.rds")

## all
x_ll <- do.call(c, lapply(l, fun))

trans <- PROJ::proj_trans_create("EPSG:4326", (prj <- "+proj=stere +lat_0=90"))

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


## which tiles does the 17673 tile touch
iid_ll[[30]]
plot(x_ll[iid_ll[[2873]]])
 }


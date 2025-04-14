library(readr)
library(stringr)

files <- read_csv("https://ogd.swisstopo.admin.ch/resources/ch.swisstopo.swissalti3d-fOYMuina.csv", col_names = FALSE)
xy_ <- str_extract(dirname(files$X1), "[0-9]{4}-[0-9]{4}")
files <- files |> dplyr::transmute(location = sprintf("/vsicurl/%s", X1))

gdalraster::set_config_option("GDAL_DISABLE_READDIR_ON_OPEN", "EMPTY_DIR")
info <- jsonlite::fromJSON(new(gdalraster::GDALRaster, files$location[1])$infoAsJSON())

dm <- info$size
res <- abs(info$geoTransform[c(2, 6)])
prj <- info$coordinateSystem$wkt
files <- files |> dplyr::mutate(xmin =  as.numeric(substr(xy_, 1, 4)) * 1000,
                                ymin =  as.numeric(substr(xy_, 6, 9)) * 1000,
                                xmax = xmin + dm[1] * res[1],
                                ymax =  ymin + dm[2] * res[2])

## actual polygons
library(terra)
v <- vect(as.character(wk::as_wkt(wk::rct(files$xmin, files$ymin, files$xmax, files$ymax))), crs =prj)
v$location <- files$location

tfile <- "data-raw/_tempswisstopo.gpkg"
writeVector(v, tfile)
epsg <- gdalraster::srs_find_epsg(prj)
nodata <- info$bands$noDataValue[1]
dtype <- info$bands$type

cmd <- sprintf("ogr2ogr data-raw/swisstopo.gti.gpkg %s  -mo DATA_TYPE=%s -mo NODATA=%s -mo SRS=%s -mo BAND_COUNT=1 -mo RESX=%f -mo RESY=%f -mo MINX=%f -mo MINY=%f -mo MAXX=%f -mo MAXY=%f  ",
               tfile, dtype, nodata, epsg, res[1], res[2],
               min(files$xmin), min(files$ymin), max(files$xmax), max(files$ymax))
system(cmd)

unlink(tfile)

r <- rast("GTI:data-raw/swisstopo.gti.gpkg")

plot(crop(r, ext(c(2615548L, 2618548L, 1090170L, 1093170L))))


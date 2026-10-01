# Cadastral parcel source

Cadastral parcel source

## Usage

``` r
list_parcel_shp()
```

## Value

string URI for List shapefile

## Examples

``` r
list_parcel_shp()  ## read with terra::vect( ) or new(gdalraster::GDALVector, )
#> [1] "/vsizip//vsicurl/https://listdata.thelist.tas.gov.au/opendata/data/LIST_PARCELS_HOBART.zip/list_parcels_hobart.shp"
```

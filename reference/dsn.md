# Data source name for a named spatial data source

Look up a source by name in the sds registry and return a GDAL-ready
data source name (DSN). The registry records the kind of every source,
so the returned string is fully dressed: '/vsicurl/' for online rasters
and Parquet, '/vsizip//vsicurl/' for zipped vector sources, complete
'WMTS:' connection strings for tile services, and full XML or VRT text
for sources that are recipes rather than URLs.

## Usage

``` r
dsn(name)
```

## Arguments

- name:

  character vector of registry names, see
  [`dsn_list()`](https://hypertidy.github.io/sds/reference/dsn_list.md)

## Value

character vector of GDAL data source names, same length as 'name'

## Details

There is deliberately no prefix toggle. If you want the bare URL, take
it from the 'url' column of
[`dsn_list()`](https://hypertidy.github.io/sds/reference/dsn_list.md),
or unchain with
[`dsn::unvsicurl()`](https://hypertidy.github.io/dsn/reference/prefix.html).
To chain further, compose with dsn verbs or the 'vrt://' protocol, for
example 'paste0("vrt://", dsn("esri_world_imagery"), "?ovr=12")'.

## Examples

``` r
dsn("gebco25")
#> [1] "/vsicurl/https://data.source.coop/ausantarctic/gebco/GEBCO_2025.tif"
dsn(c("cop30", "nasa_antarctic_modis"))
#>                                                                                                                                 cop30 
#>                                                               "/vsicurl/https://opentopography.s3.sdsc.edu/raster/COP30/COP30_hh.vrt" 
#>                                                                                                                  nasa_antarctic_modis 
#> "WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3031/best/1.0.0/WMTSCapabilities.xml,layer=MODIS_Terra_CorrectedReflectance_TrueColor" 
dsn_list(theme = "bathymetry")$name
#>  [1] "gebco25"                  "gebco24"                 
#>  [3] "gebco23"                  "gebco23_bedrock"         
#>  [5] "gebco22"                  "gebco21"                 
#>  [7] "gebco19"                  "srtm15"                  
#>  [9] "ibcso"                    "ibcso_chart"             
#> [11] "dea_250m_dem"             "gebco26"                 
#> [13] "ga_marine_geomorphic_wms"
```

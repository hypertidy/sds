# Imagery online sources

Raster and imagery online

## Usage

``` r
wms_arcgis_mapserver_ESRI.WorldImagery_tms()

wms_bluemarble_s3_tms()

wms_googlehybrid_tms()

wms_virtualearth()

wms_ESA_worldcover_2020_tms()

wms_mapbox_satellite()

wms_amazon_elevation()

wms_mapbox_terrain()

wms_openstreetmap_tms()

wms_googleterrainstreets_tms()

wms_virtualearth_street()

wms_arcgis_mapserver_tms()

nasadem()

cop90()

cop30()

srtm15()
```

## Value

character string, a GDAL data source name (a 'GDAL_WMS' XML description
or a '/vsicurl/' URL)

## Examples

``` r
cop30()
#> [1] "/vsicurl/https://opentopography.s3.sdsc.edu/raster/COP30/COP30_hh.vrt"
wms_openstreetmap_tms()
#> [1] "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>https://tile.openstreetmap.org/${z}/${x}/${y}.png</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>18</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:3857</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><!--<UserAgent>Please add a specific user agent text, to avoid the default one being used, and potentially blocked by OSM servers in case a too big usage of it would be seen</UserAgent>--><Cache /></GDAL_WMS>"
```

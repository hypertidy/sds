# Tasmania theLIST address query

Build a query URI for the Tasmanian theLIST address service.

## Usage

``` r
list_address(address)
```

## Arguments

- address:

  character vector of length 3: street number, street name, and locality

## Value

string URI for List service

## Examples

``` r
list_address(c(2862, "LYELL", "HAYES"))
#> [1] "https://services.thelist.tas.gov.au/arcgis/rest/services/Public/OpenDataWFS/MapServer/9/query?where=(ST_NO_FROM=2862%20AND%20STREET='LYELL'%20%20AND%20LOCALITY='HAYES')&outFields=EASTING,NORTHING,PID&returnGeometry=false&returnTrueCurves=false&f=pjson"
```

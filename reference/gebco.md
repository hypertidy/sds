# GEBCO source dsn

A data source name to the GEBCO elevation 'COG' GeoTIFF.

## Usage

``` r
gebco(vsi = TRUE)

gebco26(vsi = TRUE)

gebco25(vsi = TRUE)

gebco24(vsi = TRUE)

gebco21(vsi = TRUE)

gebco23_bedrock(vsi = TRUE)

gebco23(vsi = TRUE)

gebco22(vsi = TRUE)

gebco19(vsi = TRUE)
```

## Arguments

- vsi:

  include the 'vsicurl' prefix (`TRUE` is default)

## Value

character string, URL to online GeoTIFF

## Details

GEBCO 2023 and 2022 is created and hosted by Philippe Massicotte.

GEBCO 2019 and 2021 created and hosted by the Australian Antarctic
Division, served via the AADC data API (`data.aad.gov.au/eds/api`).

See note about which forms of the bedrock vs ice surface are available.
Generally we use the ice surface form, because that is what encountered
while navigating the surface of the Earth. But, the bedrock is of course
also of interest. "If the data sets are used in a presentation or
publication then we ask that you acknowledge the source. This should be
of the form (see references)."

## warning

please note that `gebco21()`, `gebco19()`, `gebco24()`, `gebco25()` and
`gebco26()` return the *ice surface* form, while `gebco22()` returns the
bedrock form. With `gebco23()` and `gebco23_bedrock()`, thanks to
Philippe Massicotte.

## References

<https://www.gebco.net/data-products/gridded-bathymetry-data> 'GEBCO
Compilation Group (2025) GEBCO 2025 Grid
(doi:10.5285/37c52e96-24ea-67ce-e063-7086abc05f29)'

GEBCO 2026, 2025 and 2024 are hosted on Source Cooperative by the
Australian Antarctic Division.

## Examples

``` r
gebco()
#> [1] "/vsicurl/https://data.source.coop/ausantarctic/gebco/GEBCO_2026.tif"
```

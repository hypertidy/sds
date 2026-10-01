# DEA 250m dem (superseded)

Australian Bathymetry and Topography 2023 250m MSL 'COG' (AusSeabed).
This source is dead: the 2023 S3 object was removed when it was
superseded by AusBathyTopo 250m 2024 (doi:10.26186/150050). Calling this
function errors with that successor information.

## Usage

``` r
dea_250m_dem(vsi = TRUE)
```

## Arguments

- vsi:

  include the 'vsicurl' prefix (`TRUE` is default)

## Value

errors; the source is superseded (see Description)

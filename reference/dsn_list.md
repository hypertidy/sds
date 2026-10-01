# List and filter the sds registry

Returns the registry as a data frame, optionally filtered. This is the
discovery surface: themes, providers, kinds, licenses, and liveness
status are all columns you can inspect.

## Usage

``` r
dsn_list(pattern = NULL, theme = NULL, provider = NULL, kind = NULL)

dsn_info(name)
```

## Arguments

- pattern:

  optional pattern matched against 'name' (grep, case insensitive)

- theme:

  optional theme filter, e.g. "elevation", "bathymetry", "imagery",
  "basemap", "admin"

- provider:

  optional provider filter, e.g. "gebco", "usgs", "nasa_gibs", "thelist"

- kind:

  optional kind filter, e.g. "cog", "wmts", "parquet"

- name:

  a single registry name

## Value

data frame, one row per source

## Examples

``` r
dsn_list(theme = "bathymetry")
#>                        name
#> 1                   gebco25
#> 2                   gebco24
#> 3                   gebco23
#> 4           gebco23_bedrock
#> 5                   gebco22
#> 6                   gebco21
#> 7                   gebco19
#> 8                    srtm15
#> 9                     ibcso
#> 10              ibcso_chart
#> 11             dea_250m_dem
#> 12                  gebco26
#> 13 ga_marine_geomorphic_wms
#>                                                                                                                                                                                                                            url
#> 1                                                                                                                                                                   https://data.source.coop/ausantarctic/gebco/GEBCO_2025.tif
#> 2                                                                                                                                                                   https://data.source.coop/ausantarctic/gebco/GEBCO_2024.tif
#> 3                                                                                                                                                                 https://gebco2023.s3.valeria.science/gebco_2023_land_cog.tif
#> 4                                                                                                                                                         https://gebco2023.s3.valeria.science/gebco_2023_sub_ice_topo_cog.tif
#> 5                                                                                                                                                             https://gebco2022.s3.valeria.science/gebco_2022_complete_cog.tif
#> 6                                                                                                           https://data.aad.gov.au/eds/api/dataset/e2211189-ff68-4ba0-be09-a8f1dbe02af6/object/download?prefix=GEBCO_2021.tif
#> 7                                                                                                           https://data.aad.gov.au/eds/api/dataset/ef32700c-bda7-4d97-916f-6ee0d3a4eb4c/object/download?prefix=GEBCO_2019.tif
#> 8                                                                                                                                                     https://opentopography.s3.sdsc.edu/raster/SRTM15Plus/SRTM15Plus_srtm.vrt
#> 9                                                                                                                                                  https://github.com/mdsumner/ibcso-cog/raw/main/IBCSO_v2_ice-surface_cog.tif
#> 10                                                                                                                                                   https://github.com/mdsumner/ibcso-cog/raw/main/IBCSO_v2_digital_chart.tif
#> 11                                            https://s3.ap-southeast-2.amazonaws.com/ausseabed-public-warehouse-bathymetry/L3/6009f454-290d-4c9a-a43d-00b254681696/Australian_Bathymetry_and_Topography_2023_250m_MSL_cog.tif
#> 12                                                                                                                                                                  https://data.source.coop/ausantarctic/gebco/GEBCO_2026.tif
#> 13 WMS:https://services.ga.gov.au/gis/services/Marine_Geomorphic_Features/MapServer/WmsServer?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&LAYERS=Geomorphic_Features&SRS=EPSG:4326&BBOX=93.412315,-60.923248,171.801102,-8.472063
#>       kind      theme       provider       crs     license needs_auth linkcheck
#> 1      cog bathymetry          gebco EPSG:4326 attribution                     
#> 2      cog bathymetry          gebco EPSG:4326 attribution                     
#> 3      cog bathymetry          gebco EPSG:4326 attribution                     
#> 4      cog bathymetry          gebco EPSG:4326 attribution                     
#> 5      cog bathymetry          gebco EPSG:4326 attribution                     
#> 6      cog bathymetry          gebco EPSG:4326 attribution                     
#> 7      cog bathymetry          gebco EPSG:4326 attribution                     
#> 8  vrt_url bathymetry opentopography EPSG:4326 attribution                     
#> 9      cog bathymetry          ibcso EPSG:9354 attribution                     
#> 10     cog bathymetry          ibcso EPSG:9354 attribution                     
#> 11     cog bathymetry             ga EPSG:4326   CC-BY-4.0                     
#> 12     cog bathymetry          gebco EPSG:4326 attribution                     
#> 13     raw bathymetry             ga EPSG:3857                                 
#>    status      added
#> 1      ok 2026-07-08
#> 2      ok 2026-07-08
#> 3      ok 2026-07-08
#> 4      ok 2026-07-08
#> 5      ok 2026-07-08
#> 6      ok 2026-07-08
#> 7      ok 2026-07-08
#> 8      ok 2026-07-08
#> 9      ok 2026-07-08
#> 10     ok 2026-07-08
#> 11   dead 2026-07-08
#> 12     ok 2026-10-01
#> 13     ok 2026-10-01
#>                                                                                                                                                                                                                             notes
#> 1                                     GEBCO 2025 ice surface. Cite: GEBCO Compilation Group (2025) GEBCO 2025 Grid doi:10.5285/37c52e96-24ea-67ce-e063-7086abc05f29. Hosted on Source Cooperative by the AAD (previously Pawsey).
#> 2                                                                                                                                            GEBCO 2024 ice surface. Hosted on Source Cooperative by the AAD (previously Pawsey).
#> 3                                                                                                                                                                             GEBCO 2023 ice surface. COG by Philippe Massicotte.
#> 4                                                                                                                                                                       GEBCO 2023 sub-ice (bedrock). COG by Philippe Massicotte.
#> 5                                                                                                                                                                            GEBCO 2022 bedrock form. COG by Philippe Massicotte.
#> 6                                              GEBCO 2021 ice surface via the AADC data API, which 302-redirects to a presigned object URL; /vsicurl/ follows the redirect. Replaces the retired public.services.aad.gov.au host.
#> 7                                                                          GEBCO 2019 ice surface via the AADC data API (302 redirect to presigned URL, /vsicurl/ follows). Replaces the retired public.services.aad.gov.au host.
#> 8                                                                                                                                                                               SRTM15+ global topo-bathy via OpenTopography VRT.
#> 9                                                                                                                                                                                                       IBCSO v2 ice surface COG.
#> 10                                                                                                                                                                                                  IBCSO v2 digital chart image.
#> 11 AusBathyTopo 250m 2023, superseded 2024-12-05 by AusBathyTopo 250m 2024 (eCat 150050, doi:10.26186/150050); the 2023 S3 object is gone. Add the 2024 COG once located in the ausseabed-public-warehouse-bathymetry L3 listing.
#> 12                                                                                                                                     GEBCO 2026 ice surface. Hosted on Source Cooperative by the Australian Antarctic Division.
#> 13                                                                       GA marine geomorphic features as a full WMS GetMap connection string. From the unexported ozgrab grab-bag; unvalidated until the link check adjudicates.
dsn_list(provider = "nasa_gibs")
#>                         name
#> 1           nasa_blue_marble
#> 2 nasa_modis_terra_truecolor
#> 3  nasa_viirs_snpp_truecolor
#> 4 nasa_antarctic_blue_marble
#> 5       nasa_antarctic_modis
#> 6    nasa_arctic_blue_marble
#>                                                                                                                                   url
#> 1                  WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3857/best/1.0.0/WMTSCapabilities.xml,layer=BlueMarble_NextGeneration
#> 2 WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3857/best/1.0.0/WMTSCapabilities.xml,layer=MODIS_Terra_CorrectedReflectance_TrueColor
#> 3  WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3857/best/1.0.0/WMTSCapabilities.xml,layer=VIIRS_SNPP_CorrectedReflectance_TrueColor
#> 4                  WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3031/best/1.0.0/WMTSCapabilities.xml,layer=BlueMarble_NextGeneration
#> 5 WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3031/best/1.0.0/WMTSCapabilities.xml,layer=MODIS_Terra_CorrectedReflectance_TrueColor
#> 6                  WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3413/best/1.0.0/WMTSCapabilities.xml,layer=BlueMarble_NextGeneration
#>   kind   theme  provider       crs       license needs_auth linkcheck status
#> 1 wmts imagery nasa_gibs EPSG:3857 public-domain                          ok
#> 2 wmts imagery nasa_gibs EPSG:3857 public-domain                          ok
#> 3 wmts imagery nasa_gibs EPSG:3857 public-domain                          ok
#> 4 wmts imagery nasa_gibs EPSG:3031 public-domain                          ok
#> 5 wmts imagery nasa_gibs EPSG:3031 public-domain                          ok
#> 6 wmts imagery nasa_gibs EPSG:3413 public-domain                          ok
#>        added
#> 1 2026-07-08
#> 2 2026-07-08
#> 3 2026-07-08
#> 4 2026-07-08
#> 5 2026-07-08
#> 6 2026-07-08
#>                                                                                             notes
#> 1                                            NASA GIBS Blue Marble Next Generation, web mercator.
#> 2                    MODIS Terra true colour, time-varying layer (GIBS serves latest by default).
#> 3                                                     VIIRS SNPP true colour, time-varying layer.
#> 4 Blue Marble in native Antarctic polar stereographic. No reprojection needed for 3031 workflows.
#> 5                                                      MODIS Terra true colour, native EPSG:3031.
#> 6                                               Blue Marble in native Arctic polar stereographic.
dsn_list("antarctic")
#>                         name
#> 1 nasa_antarctic_blue_marble
#> 2       nasa_antarctic_modis
#>                                                                                                                                   url
#> 1                  WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3031/best/1.0.0/WMTSCapabilities.xml,layer=BlueMarble_NextGeneration
#> 2 WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3031/best/1.0.0/WMTSCapabilities.xml,layer=MODIS_Terra_CorrectedReflectance_TrueColor
#>   kind   theme  provider       crs       license needs_auth linkcheck status
#> 1 wmts imagery nasa_gibs EPSG:3031 public-domain                          ok
#> 2 wmts imagery nasa_gibs EPSG:3031 public-domain                          ok
#>        added
#> 1 2026-07-08
#> 2 2026-07-08
#>                                                                                             notes
#> 1 Blue Marble in native Antarctic polar stereographic. No reprojection needed for 3031 workflows.
#> 2                                                      MODIS Terra true colour, native EPSG:3031.
```

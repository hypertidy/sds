# Package index

## The registry

Look up, list, and inspect named spatial data sources. The registry is
the single source of truth; every source function below is a thin shim
over [`dsn()`](https://hypertidy.github.io/sds/reference/dsn.md).

- [`dsn()`](https://hypertidy.github.io/sds/reference/dsn.md) : Data
  source name for a named spatial data source
- [`dsn_list()`](https://hypertidy.github.io/sds/reference/dsn_list.md)
  [`dsn_info()`](https://hypertidy.github.io/sds/reference/dsn_list.md)
  : List and filter the sds registry

## Elevation (land)

Global and regional digital elevation models.

- [`wms_arcgis_mapserver_ESRI.WorldImagery_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_bluemarble_s3_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_googlehybrid_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_virtualearth()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_ESA_worldcover_2020_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_mapbox_satellite()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_amazon_elevation()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_mapbox_terrain()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_openstreetmap_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_googleterrainstreets_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_virtualearth_street()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_arcgis_mapserver_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`nasadem()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`cop90()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`cop30()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`srtm15()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  : Imagery online sources
- [`usgs_seamless()`](https://hypertidy.github.io/sds/reference/usgs_seamless.md)
  : USGS seamless DEM
- [`mapterhorn_elevation()`](https://hypertidy.github.io/sds/reference/mapterhorn_elevation.md)
  : Mapterhorn PMTiles raster elevation
- [`tas_dem()`](https://hypertidy.github.io/sds/reference/tas_dem.md) :
  Tasmania DEM (2m)
- [`rema()`](https://hypertidy.github.io/sds/reference/rema.md)
  [`rema_v2()`](https://hypertidy.github.io/sds/reference/rema.md) :
  REMA reference elevation model of Antarctica

## Bathymetry & topography

Seamless land/sea elevation and bathymetric compilations.

- [`gebco()`](https://hypertidy.github.io/sds/reference/gebco.md)
  [`gebco26()`](https://hypertidy.github.io/sds/reference/gebco.md)
  [`gebco25()`](https://hypertidy.github.io/sds/reference/gebco.md)
  [`gebco24()`](https://hypertidy.github.io/sds/reference/gebco.md)
  [`gebco21()`](https://hypertidy.github.io/sds/reference/gebco.md)
  [`gebco23_bedrock()`](https://hypertidy.github.io/sds/reference/gebco.md)
  [`gebco23()`](https://hypertidy.github.io/sds/reference/gebco.md)
  [`gebco22()`](https://hypertidy.github.io/sds/reference/gebco.md)
  [`gebco19()`](https://hypertidy.github.io/sds/reference/gebco.md) :
  GEBCO source dsn
- [`ibcso()`](https://hypertidy.github.io/sds/reference/ibcso.md) :
  IBCOS source dsn
- [`dea_250m_dem()`](https://hypertidy.github.io/sds/reference/dea_250m_dem.md)
  : DEA 250m dem (superseded)

## Administrative & vector boundaries

Country boundaries and vector features.

- [`CGAZ()`](https://hypertidy.github.io/sds/reference/CGAZ.md)
  [`CGAZ_sql()`](https://hypertidy.github.io/sds/reference/CGAZ.md) :
  the geoBoundaries countries
- [`gadm()`](https://hypertidy.github.io/sds/reference/gadm.md) : GADM
  administrative boundaries
- [`addrock()`](https://hypertidy.github.io/sds/reference/addrock.md) :
  Medium resolution vector polygons of Antarctic rock outcrop - VERSION
  7.3

## Imagery & basemaps

Tile servers and WMS/TMS image sources, returned as GDAL data source
descriptions.

- [`wms_arcgis_mapserver_ESRI.WorldImagery_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_bluemarble_s3_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_googlehybrid_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_virtualearth()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_ESA_worldcover_2020_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_mapbox_satellite()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_amazon_elevation()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_mapbox_terrain()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_openstreetmap_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_googleterrainstreets_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_virtualearth_street()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`wms_arcgis_mapserver_tms()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`nasadem()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`cop90()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`cop30()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  [`srtm15()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  : Imagery online sources
- [`sentinel2_wms()`](https://hypertidy.github.io/sds/reference/sentinel2_wms.md)
  : Sentinel 2 WMS

## Ocean & climate

Sea ice, sea-surface temperature, and ocean colour.

- [`nsidc_seaice()`](https://hypertidy.github.io/sds/reference/nsidc_seaice.md)
  : Data sources for NOAA NSIDC GeoTIFF images for sea ice concentration
  and extent.
- [`seaice_cdr()`](https://hypertidy.github.io/sds/reference/seaice_cdr.md)
  : Sea ice CDR (climate data record) url
- [`ghrsst()`](https://hypertidy.github.io/sds/reference/ghrsst.md) :
  GHRSST files, GeoTIFFs on source.coop
- [`mursst_zarr()`](https://hypertidy.github.io/sds/reference/mursst.md)
  [`mursst_time()`](https://hypertidy.github.io/sds/reference/mursst.md)
  : MURSST (GHRSST) sst Zarr source
- [`esacci_chlor_a()`](https://hypertidy.github.io/sds/reference/esacci_chlor_a.md)
  : ESACCI chlorophyll-a in monthly

## STAC catalogs

SpatioTemporal Asset Catalog query helpers for use with GDAL.

- [`stacit()`](https://hypertidy.github.io/sds/reference/stacit.md) :
  STAC Query URL Generator
- [`mpc()`](https://hypertidy.github.io/sds/reference/mpc.md) :
  Microsoft Planetary Computer

## Cadastre (Tasmania)

Tasmanian theLIST cadastral services.

- [`list_address()`](https://hypertidy.github.io/sds/reference/list_address.md)
  : Tasmania theLIST address query
- [`list_parcel_shp()`](https://hypertidy.github.io/sds/reference/list_parcel_shp.md)
  : Cadastral parcel source

## Data

- [`sentinel_grid`](https://hypertidy.github.io/sds/reference/sentinel_grid.md)
  : Sentinel-2 MGRS tile grid

## Package

- [`sds`](https://hypertidy.github.io/sds/reference/sds-package.md)
  [`sds-package`](https://hypertidy.github.io/sds/reference/sds-package.md)
  : sds: Spatial Data Sources

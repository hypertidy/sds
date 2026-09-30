# sds 0.3.0

* The registry (`inst/extdata/sds-registry.csv`) is now the single source of
  truth for constant sources: the legacy functions (`gebco()` suite, `cop30()`,
  `rema()`, `CGAZ()`, `addrock()`, `tas_dem()`, `ibcso()`, the `wms_*` family,
  and friends) are one-line shims over `dsn()`. Edit the CSV, not the
  functions; equivalence is enforced by tests.

* The GDAL_WMS XML recipes (`wms_*`) and the mapterhorn VRT now live as
  readable files in `inst/sources/`, each with a registry row. The two
  `wms_mapbox_*` functions remain token templates and are not rows.
  `wms_amazon_elevation()` no longer bakes in a stale 2022 UserAgent.

* New export `gadm()`, GADM 4.1 whole-planet GeoParquet hosted as an sds
  release asset; the geodata.ucdavis.edu GeoPackage remains available as
  `dsn("gadm_gpkg")`.

* Registry catch-up with the GEBCO rehosting: `gebco26` row added, 2024-2026
  served from Source Cooperative, 2019/2021 via the AADC data API.

* Fix: `ibcso(chart = TRUE)` pointed at a misspelled (404) filename; now
  registry-backed and regression-tested.

* Dead sources now say so: `dea_250m_dem()` errors with its successor
  (AusBathyTopo 250m 2024, doi:10.26186/150050) instead of returning a 404
  URL; `esri_ocean` (retired 2022) and `usgs_tnmblank` are marked dead;
  `CGAZ(old = TRUE)` warns. `ga_national_map` service name corrected
  (NationalBaseMap) and a greyscale variant added.

* The registry gained a `linkcheck` column (`skip` for sources alive but
  unreachable from CI), and the ozgrab grab-bag of Australian state services
  is promoted to named rows (sa/qld/nsw/wa/vic), adjudicated by the weekly
  link check.

* Removed unexported duplicates superseded by registry rows (the usgs_*
  WMTS functions, `tasmap_sources()`, the geoserver helpers); all remain
  available via `dsn()` / `dsn_list()`.

# sds 0.2.0

* New `gebco26()` for the GEBCO 2026 grid, and `gebco()` now defaults to it.
  `gebco26()`, `gebco25()`, and `gebco24()` are now served from Source
  Cooperative (`https://data.source.coop/ausantarctic/gebco/`), hosted by the
  Australian Antarctic Division.

* `gebco21()` and `gebco19()` now use the stable AADC data API endpoint
  (`data.aad.gov.au/eds/api`), replacing the retired
  `public.services.aad.gov.au` host. `/vsicurl/` follows the API's redirect to
  the (short-lived, presigned) object URL.

* New registry backend: all constant sources now live in a plain CSV
  (`inst/extdata/sds-registry.csv`), one row per source. Adding a source is a
  one-line PR.

* New `dsn(name)` returns a GDAL-ready data source name, dressed by kind
  (`/vsicurl/`, `/vsizip//vsicurl/`, `WMTS:`, or full XML/VRT text). No `vsi`
  toggle -- the registry knows the kind. Undress with `dsn::unvsicurl()` or
  take the bare url from `dsn_list()`.

* New `dsn_list()` and `dsn_info()` for discovery -- filter by theme,
  provider, kind; inspect crs, license, and liveness status.

* Existing source functions (`gebco()`, `cop30()`, etc.) are retained as
  thin shims over `dsn()`, no change to their behaviour.

* Depends on the `dsn` package for chainable VSI prefix verbs
  (`vsicurl()`, `vsizip()`, ...).

* Many previously-unexported sources are now discoverable via the registry,
  including USGS and Tasmania (theLIST) WMTS, and AADC/DEA geoservers.

* Added WMTS catalog entries (ESRI, NASA GIBS incl. native Antarctic
  EPSG:3031 and Arctic EPSG:3413, Geoscience Australia, swisstopo),
  cherry-picked from the `sources-wmts-coop` branch (#13).

* Added GADM 4.1 whole-planet administrative boundaries (`gadm`), companion
  to `CGAZ()`.

* WMS and VRT payloads (OpenStreetMap TMS, mapterhorn) moved out of R source
  into `inst/sources/` files -- readable and diffable.

* Fix: `stacit(gdal_stacit = TRUE)` no longer errors on a removed `asset`.

* Fix: `mursst_time()` now calls `mursst_zarr()` (was calling a renamed
  function).

* Fix: `seaice_cdr()` no longer depends on dplyr (`case_when` replaced;
  sensor-era table shared with `cdr_urls()`).

* Fix: removed duplicate `usgs_shade()` definition; documented the
  `sentinel_grid` dataset and ship it once.

# sds 0.1.0.9015

* Add climate data record sea ice (full sequence)

* Add mapterhorn_elevation. 

* Add GEBCO 2025. 

* GEDTM sources list is a dog's breakfast so have removed for now. 

* Western anti-meridian queries are now handled (Issue #12). Removed unused asset from stacit(). 

* Fix: update nsidc_seaice to version 4.0, #14. 

* Accept MGRS code (precision 0) for stacit extent. 

* Fast CGAZ. 


* Fixed nsidc_seaice() for monthly. 

* Add Swiss topo as a GTI file. 

* Added GHRSST COGs
. 

* Added GEBCO 2024.

* Now more robust handling of date inputs for stacit(). 

* New source `usgs_seamless()` elevation from the US. 

* `CGAZ_sql()` now works with no arguments, and returns a general query useable by vapour_read_geometry() and friends. 

* Add `rema()` and `rema_v2()`. 

# sds 0.0.1

* Renamed from spatial.datasources. 

# spatial.datasources 0.0.0.9000

* All data sources from dsn are now here. 

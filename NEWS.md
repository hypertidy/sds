# sds 0.2.0

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

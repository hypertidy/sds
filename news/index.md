# Changelog

## sds 0.3.0

- The registry (`inst/extdata/sds-registry.csv`) is now the single
  source of truth for constant sources: the legacy functions
  ([`gebco()`](https://hypertidy.github.io/sds/reference/gebco.md)
  suite,
  [`cop30()`](https://hypertidy.github.io/sds/reference/dsn-sources.md),
  [`rema()`](https://hypertidy.github.io/sds/reference/rema.md),
  [`CGAZ()`](https://hypertidy.github.io/sds/reference/CGAZ.md),
  [`addrock()`](https://hypertidy.github.io/sds/reference/addrock.md),
  [`tas_dem()`](https://hypertidy.github.io/sds/reference/tas_dem.md),
  [`ibcso()`](https://hypertidy.github.io/sds/reference/ibcso.md), the
  `wms_*` family, and friends) are one-line shims over
  [`dsn()`](https://hypertidy.github.io/sds/reference/dsn.md). Edit the
  CSV, not the functions; equivalence is enforced by tests.

- The GDAL_WMS XML recipes (`wms_*`) and the mapterhorn VRT now live as
  readable files in `inst/sources/`, each with a registry row. The two
  `wms_mapbox_*` functions remain token templates and are not rows.
  [`wms_amazon_elevation()`](https://hypertidy.github.io/sds/reference/dsn-sources.md)
  no longer bakes in a stale 2022 UserAgent.

- New export
  [`gadm()`](https://hypertidy.github.io/sds/reference/gadm.md), GADM
  4.1 whole-planet GeoParquet hosted as an sds release asset; the
  geodata.ucdavis.edu GeoPackage remains available as
  `dsn("gadm_gpkg")`.

- Registry catch-up with the GEBCO rehosting: `gebco26` row added,
  2024-2026 served from Source Cooperative, 2019/2021 via the AADC data
  API.

- Fix: `ibcso(chart = TRUE)` pointed at a misspelled (404) filename; now
  registry-backed and regression-tested.

- Dead sources now say so:
  [`dea_250m_dem()`](https://hypertidy.github.io/sds/reference/dea_250m_dem.md)
  errors with its successor (AusBathyTopo 250m 2024,
  <doi:10.26186/150050>) instead of returning a 404 URL; `esri_ocean`
  (retired 2022) and `usgs_tnmblank` are marked dead; `CGAZ(old = TRUE)`
  warns. `ga_national_map` service name corrected (NationalBaseMap) and
  a greyscale variant added.

- The registry gained a `linkcheck` column (`skip` for sources alive but
  unreachable from CI), and the ozgrab grab-bag of Australian state
  services is promoted to named rows (sa/qld/nsw/wa/vic), adjudicated by
  the weekly link check.

- Link checker hardening: WMS `raw` rows are now probed via
  `GetCapabilities` (a bare `GetMap` string cannot be validated), the
  weekly run appends a per-source history to `.github/linkcheck-log.csv`
  so link rot is tracked over time, and the report issue’s label is
  created if missing. The audit retired `ga_canberra_2014_wms` (its GA
  service returns HTTP 400 even for `GetCapabilities`).

- Removed unexported duplicates superseded by registry rows (the
  usgs\_\* WMTS functions, `tasmap_sources()`, the geoserver helpers);
  all remain available via
  [`dsn()`](https://hypertidy.github.io/sds/reference/dsn.md) /
  [`dsn_list()`](https://hypertidy.github.io/sds/reference/dsn_list.md).

## sds 0.2.0

- New [`gebco26()`](https://hypertidy.github.io/sds/reference/gebco.md)
  for the GEBCO 2026 grid, and
  [`gebco()`](https://hypertidy.github.io/sds/reference/gebco.md) now
  defaults to it.
  [`gebco26()`](https://hypertidy.github.io/sds/reference/gebco.md),
  [`gebco25()`](https://hypertidy.github.io/sds/reference/gebco.md), and
  [`gebco24()`](https://hypertidy.github.io/sds/reference/gebco.md) are
  now served from Source Cooperative
  (`https://data.source.coop/ausantarctic/gebco/`), hosted by the
  Australian Antarctic Division.

- [`gebco21()`](https://hypertidy.github.io/sds/reference/gebco.md) and
  [`gebco19()`](https://hypertidy.github.io/sds/reference/gebco.md) now
  use the stable AADC data API endpoint (`data.aad.gov.au/eds/api`),
  replacing the retired `public.services.aad.gov.au` host. `/vsicurl/`
  follows the API’s redirect to the (short-lived, presigned) object URL.

- New registry backend: all constant sources now live in a plain CSV
  (`inst/extdata/sds-registry.csv`), one row per source. Adding a source
  is a one-line PR.

- New `dsn(name)` returns a GDAL-ready data source name, dressed by kind
  (`/vsicurl/`, `/vsizip//vsicurl/`, `WMTS:`, or full XML/VRT text). No
  `vsi` toggle – the registry knows the kind. Undress with
  [`dsn::unvsicurl()`](https://hypertidy.github.io/dsn/reference/prefix.html)
  or take the bare url from
  [`dsn_list()`](https://hypertidy.github.io/sds/reference/dsn_list.md).

- New
  [`dsn_list()`](https://hypertidy.github.io/sds/reference/dsn_list.md)
  and
  [`dsn_info()`](https://hypertidy.github.io/sds/reference/dsn_list.md)
  for discovery – filter by theme, provider, kind; inspect crs, license,
  and liveness status.

- Existing source functions
  ([`gebco()`](https://hypertidy.github.io/sds/reference/gebco.md),
  [`cop30()`](https://hypertidy.github.io/sds/reference/dsn-sources.md),
  etc.) are retained as thin shims over
  [`dsn()`](https://hypertidy.github.io/sds/reference/dsn.md), no change
  to their behaviour.

- Depends on the `dsn` package for chainable VSI prefix verbs
  (`vsicurl()`, `vsizip()`, …).

- Many previously-unexported sources are now discoverable via the
  registry, including USGS and Tasmania (theLIST) WMTS, and AADC/DEA
  geoservers.

- Added WMTS catalog entries (ESRI, NASA GIBS incl. native Antarctic
  EPSG:3031 and Arctic EPSG:3413, Geoscience Australia, swisstopo),
  cherry-picked from the `sources-wmts-coop` branch
  ([\#13](https://github.com/hypertidy/sds/issues/13)).

- Added GADM 4.1 whole-planet administrative boundaries (`gadm`),
  companion to
  [`CGAZ()`](https://hypertidy.github.io/sds/reference/CGAZ.md).

- WMS and VRT payloads (OpenStreetMap TMS, mapterhorn) moved out of R
  source into `inst/sources/` files – readable and diffable.

- Fix: `stacit(gdal_stacit = TRUE)` no longer errors on a removed
  `asset`.

- Fix:
  [`mursst_time()`](https://hypertidy.github.io/sds/reference/mursst.md)
  now calls
  [`mursst_zarr()`](https://hypertidy.github.io/sds/reference/mursst.md)
  (was calling a renamed function).

- Fix:
  [`seaice_cdr()`](https://hypertidy.github.io/sds/reference/seaice_cdr.md)
  no longer depends on dplyr (`case_when` replaced; sensor-era table
  shared with `cdr_urls()`).

- Fix: removed duplicate `usgs_shade()` definition; documented the
  `sentinel_grid` dataset and ship it once.

## sds 0.1.0.9015

- Add climate data record sea ice (full sequence)

- Add mapterhorn_elevation.

- Add GEBCO 2025.

- GEDTM sources list is a dog’s breakfast so have removed for now.

- Western anti-meridian queries are now handled (Issue
  [\#12](https://github.com/hypertidy/sds/issues/12)). Removed unused
  asset from stacit().

- Fix: update nsidc_seaice to version 4.0,
  [\#14](https://github.com/hypertidy/sds/issues/14).

- Accept MGRS code (precision 0) for stacit extent.

- Fast CGAZ.

- Fixed nsidc_seaice() for monthly.

- Add Swiss topo as a GTI file.

- Added GHRSST COGs .

- Added GEBCO 2024.

- Now more robust handling of date inputs for stacit().

- New source
  [`usgs_seamless()`](https://hypertidy.github.io/sds/reference/usgs_seamless.md)
  elevation from the US.

- [`CGAZ_sql()`](https://hypertidy.github.io/sds/reference/CGAZ.md) now
  works with no arguments, and returns a general query useable by
  vapour_read_geometry() and friends.

- Add [`rema()`](https://hypertidy.github.io/sds/reference/rema.md) and
  [`rema_v2()`](https://hypertidy.github.io/sds/reference/rema.md).

## sds 0.0.1

- Renamed from spatial.datasources.

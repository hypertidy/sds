# sds registry draft: notes

Validated end-to-end (loader, dressing per kind, vectorized dsn(), error
suggestions, deprecation warning, filters, ASCII-clean). 68 seed rows.

## What is in this draft

- inst/extdata/sds-registry.csv
  Seed rows: all constant exports from main; the dormant unexported
  inventory (6 USGS WMTS, 17 tasmap, AADC/DEA geoservers); cherry-picked
  WMTS entries from the sources-wmts-coop branch (ESRI, NASA GIBS incl.
  EPSG:3031 and EPSG:3413, GA, swisstopo).
- R/registry.R
  dsn(), dsn_list(), dsn_info(); dressing expressed in dsn:: verbs;
  no vsi toggle by design.
- inst/sources/
  Two payload files demonstrating xml_file and vrt_file kinds:
  wms_openstreetmap_tms.xml (pretty-printed) and mapterhorn_elevation.vrt
  (extracted verbatim from R/mapterhorn_elevation.R).
- tests/testthat/test-registry.R
  Integrity, dressing, vectorization, status, filters, and shim
  equivalence against legacy strings.
- dsn-additions.R
  vsizip(), vsis3(), vsitar(), vsigzip() for the dsn package, joining the
  existing @name prefix roxygen group. sds needs vsizip(); the others
  complete the chainable vocabulary. Land this in dsn first, tag a
  version, then sds DESCRIPTION gets Imports: dsn (>= that version).

## Decisions embedded here (flagging so nothing lands silently)

1. No vsi argument on dsn(). The registry knows the kind, so dressing is
   unconditional. Bare URLs come from dsn_list()$url or dsn::unvsicurl().
   Legacy shims keep vsi= for compatibility only.
2. WMTS rows store the complete connection string (WMTS: prefix, layer,
   tilematrixset) in the url column; kind wmts means identity dressing.
   Rationale: layer and tilematrixset are part of the identity of the
   source, not dressing.
3. zip_vector composes as vsizip(vsicurl(url)) where url may include the
   inner path after .zip. Verified against addrock including its spaces.
4. Registry names are snake_case and drop the wms_/dsn-era prefixes for
   new entries (tasmania_dem_2m not tas_dem); legacy shims preserve old
   spellings.

## Corrections made while seeding (verify before merge)

- list_parcel_shp: original string had no https:// scheme; added.
- tasmap street: original entry had no WMTS: prefix and no layer arg;
  normalized, but the layer name (Raster_TTSA) is a guess from the path
  and needs checking against the capabilities document.
- ibcso_chart: the published filename really is IBSCO (transposed); noted.
- cgaz_zip seeded as status deprecated to demonstrate the warning path.

## Not yet migrated (Stage 2 continues)

- The remaining wms_* XML payloads (arcgis, bluemarble, google x2,
  virtualearth x2, ESA worldcover, mapbox x2, amazon elevation): each
  needs pretty-printing into inst/sources/ and a row. The mapbox pair
  embed %s token slots for access tokens: either give them
  needs_auth=MAPBOX_ACCESS_TOKEN and sprintf at dress time (a new kind,
  xml_file_token), or leave them as grammar functions. Decide then.
- ozgrab_bag_sources: unnamed and unvalidated; run each through the link
  checker before naming rows.
- source_coop entries from the branch: flatten formats into suffixed rows
  (name_parquet, name_pmtiles, name_fgb). An s3 protocol variant would use
  dsn::vsis3() with a kind like s3_parquet; the https form is a plain
  parquet row.
- swisstopo GTI (data-raw/swisstopo.gti.gpkg): host as a release asset
  like the CGAZ parquet and register the URL; do not ship 15MB in the
  package.

## Wiring checklist

- DESCRIPTION: Imports: dsn (remote: hypertidy/dsn until CRAN/r-universe)
- NAMESPACE: export(dsn), export(dsn_list), export(dsn_info)
- Shims move to themed files (R/elevation.R etc.) using the pattern at the
  bottom of registry.R; delete the constant bodies they replace
- Registry integrity test doubles as the PR gate for catalog contributions
- Link-checker Action (Stage 4) reads the same CSV; the status column is
  where it writes

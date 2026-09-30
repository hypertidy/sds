test_that("registry is well formed", {
  reg <- sds:::.registry()
  expect_true(nrow(reg) > 0)
  expect_false(anyDuplicated(reg$name) > 0)
  expect_true(all(nzchar(reg$name)))
  expect_true(all(nzchar(reg$url)))
  expect_false(any(grepl("^\\s|\\s$", reg$url)))

  bad <- setdiff(unique(reg$kind), sds:::.sds_kinds)
  expect_true(length(bad) == 0,
              info = sprintf("unknown kind(s): %s",
                             paste(sprintf("<%s>", bad), collapse = ", ")))
  expect_true(all(reg$status %in% c("ok", "deprecated", "dead")))
  expect_true(all(reg$linkcheck %in% c("", "skip")))
  ## wmts rows carry their own complete connection string
  expect_true(all(grepl("^WMTS:", reg$url[reg$kind == "wmts"])))
  ## url-kinds carry a scheme and no pre-applied vsi prefix
  urlkinds <- reg$kind %in% c("cog", "vrt_url", "parquet", "zip_vector")
  expect_true(all(grepl("^https?://", reg$url[urlkinds])))
  expect_false(any(grepl("^/vsi", reg$url)))
  ## payload files exist
  filekinds <- reg$kind %in% c("xml_file", "vrt_file")
  paths <- vapply(reg$url[filekinds],
                  function(f) system.file("sources", f, package = "sds"),
                  character(1))
  expect_true(all(nzchar(paths)))
})

test_that("dsn() dresses by kind", {
  expect_identical(
    dsn("gebco25"),
    "/vsicurl/https://data.source.coop/ausantarctic/gebco/GEBCO_2025.tif"
  )
  expect_identical(
    dsn("cop30"),
    "/vsicurl/https://opentopography.s3.sdsc.edu/raster/COP30/COP30_hh.vrt"
  )
  expect_match(dsn("addrock"), "^/vsizip//vsicurl/https://")
  expect_match(dsn("esri_world_imagery"), "^WMTS:")
  expect_match(dsn("wms_openstreetmap_tms"), "^<GDAL_WMS>")
  expect_match(dsn("mapterhorn_elevation"), "^<VRTDataset")
})

test_that("dsn() is vectorized and errors helpfully", {
  out <- dsn(c("gebco25", "cop30"))
  expect_length(out, 2L)
  expect_error(dsn("gebc"), "Did you mean")
  expect_error(dsn("nope_not_a_source"), "dsn_list")
})

test_that("status is honored", {
  expect_warning(dsn("cgaz_zip"), "deprecated")
})

test_that("dsn_list filters", {
  expect_true(all(dsn_list(theme = "bathymetry")$theme == "bathymetry"))
  expect_true(all(dsn_list(kind = "wmts")$kind == "wmts"))
  expect_true(nrow(dsn_list("antarctic")) >= 2)
})

test_that("shims match legacy strings", {
  ## equivalence with the pre-registry API, taken verbatim from sds 0.0.1.9015
  legacy_gebco25 <- "/vsicurl/https://data.source.coop/ausantarctic/gebco/GEBCO_2025.tif"
  legacy_cop30 <- "/vsicurl/https://opentopography.s3.sdsc.edu/raster/COP30/COP30_hh.vrt"
  legacy_tasdem <- "/vsicurl/https://s3.us-west-2.amazonaws.com/us-west-2.opendata.source.coop/alexgleith/tasmania-dem-2m/Tasmania_Statewide_2m_DEM_14-08-2021.tif"
  expect_identical(dsn("gebco25"), legacy_gebco25)
  expect_identical(dsn("cop30"), legacy_cop30)
  expect_identical(dsn("tasmania_dem_2m"), legacy_tasdem)
})


test_that("legacy functions are registry shims (no second source of truth)", {
  ## constant functions must agree with the registry, by construction
  expect_identical(gebco(), dsn("gebco26"))
  expect_identical(gebco26(),
    "/vsicurl/https://data.source.coop/ausantarctic/gebco/GEBCO_2026.tif")
  expect_identical(gebco25(vsi = FALSE),
    "https://data.source.coop/ausantarctic/gebco/GEBCO_2025.tif")
  expect_match(gebco21(), "^/vsicurl/https://data.aad.gov.au/eds/api/")
  expect_identical(cop30(), dsn("cop30"))
  expect_identical(usgs_seamless(vsicurl = FALSE),
    "https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/1/TIFF/USGS_Seamless_DEM_1.vrt")
  expect_identical(tas_dem(), dsn("tasmania_dem_2m"))
  expect_identical(rema(), dsn("rema_v2"))
  expect_identical(CGAZ(), dsn("cgaz"))
  expect_identical(addrock(), dsn("addrock"))
  expect_identical(gadm(), dsn("gadm"))
  expect_identical(list_parcel_shp(), dsn("list_parcel_shp"))
})

test_that("ibcso chart spelling regression (IBSCO typo)", {
  expect_match(ibcso(chart = TRUE), "IBCSO_v2_digital_chart", fixed = TRUE)
  expect_no_match(ibcso(chart = TRUE), "IBSCO", fixed = TRUE)
})

test_that("payload shims return recipes, not URLs", {
  expect_match(wms_openstreetmap_tms(), "^<GDAL_WMS>")
  expect_match(wms_ESA_worldcover_2020_tms(), "WORLDCOVER_2020_MAP", fixed = TRUE)
  expect_match(mapterhorn_elevation(), "^<VRTDataset")
  ## mapbox templates keep their token slot and are not registry rows
  expect_match(wms_mapbox_satellite(), "access_token=%s", fixed = TRUE)
})

test_that("status is enforced through the shims", {
  expect_error(dea_250m_dem(), "superseded")
  expect_warning(CGAZ(old = TRUE), "deprecated")
})

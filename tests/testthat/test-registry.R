
.sds_kinds <- c("cog", "gpkg", "parquet", "raw", "vrt_file", "vrt_url", "wmts",
                "xml_file", "zip_vector")
test_that("registry is well formed", {
  reg <- sds:::.registry()
  expect_true(nrow(reg) > 0)
  expect_false(anyDuplicated(reg$name) > 0)
  expect_true(all(nzchar(reg$name)))
  expect_true(all(nzchar(reg$url)))
  expect_false(any(grepl("^\\s|\\s$", reg$url)))

  expect_true(all(reg$kind %in% .sds_kinds))
  expect_true(all(reg$status %in% c("ok", "deprecated", "dead")))
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
    "/vsicurl/https://projects.pawsey.org.au/idea-gebco-tif/GEBCO_2025.tif"
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
  legacy_gebco25 <- "/vsicurl/https://projects.pawsey.org.au/idea-gebco-tif/GEBCO_2025.tif"
  legacy_cop30 <- "/vsicurl/https://opentopography.s3.sdsc.edu/raster/COP30/COP30_hh.vrt"
  legacy_tasdem <- "/vsicurl/https://s3.us-west-2.amazonaws.com/us-west-2.opendata.source.coop/alexgleith/tasmania-dem-2m/Tasmania_Statewide_2m_DEM_14-08-2021.tif"
  expect_identical(dsn("gebco25"), legacy_gebco25)
  expect_identical(dsn("cop30"), legacy_cop30)
  expect_identical(dsn("tasmania_dem_2m"), legacy_tasdem)
})

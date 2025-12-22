test_that("date string inputs work as intervals", {
  ## single strings
  expect_equal(.datehandler("2024"), "2024-01-01T00:00:00Z/2024-12-31T23:59:59Z")
  expect_equal(.datehandler("2024-01"), "2024-01-01T00:00:00Z/2024-01-31T23:59:59Z")
  expect_equal(.datehandler("2024-02"), "2024-02-01T00:00:00Z/2024-02-29T23:59:59Z")
  expect_equal(.datehandler("2023-02"), "2023-02-01T00:00:00Z/2023-02-28T23:59:59Z")
  expect_equal(.datehandler("2023-01-01"), "2023-01-01T00:00:00Z/2023-01-01T23:59:59Z")

  expect_equal(.datehandler(c("2024-02-01", "2024-02-29")),
               "2024-02-01T00:00:00Z/2024-02-29T23:59:59Z")

  expect_equal(.datehandler(as.Date(c("2024-02-01", "2024-02-29"))),
               "2024-02-01T00:00:00Z/2024-02-29T23:59:59Z")

  expect_equal(.datehandler(as.POSIXct(c("2024-02-01 12:00:02", "2024-02-19 04:00:10"), tz = "UTC")),
               "2024-02-01T12:00:02Z/2024-02-19T04:00:10Z")

  expect_error(.datehandler(c("2024-02-01", "2024-01-31")))

})

test_that("stacit includes datetime in URL", {
  skip_if_not_installed("sds")

  result <- stacit(c(140, 145, -40, -35), date = "2024-06")
  expect_match(result, "datetime=2024-06-01T00:00:00Z/2024-06-30T23:59:59Z")
})

test_that("stacit accepts various datetime formats", {
  skip_if_not_installed("sds")

  bbox <- c(140, 145, -40, -35)


  # Year only
  expect_match(stacit(bbox, date = "2024"),
               "datetime=2024-01-01T00:00:00Z/2024-12-31T23:59:59Z")

  # Year-month
  expect_match(stacit(bbox, date = "2024-03"),
               "datetime=2024-03-01T00:00:00Z/2024-03-31T23:59:59Z")

  # Full date
  expect_match(stacit(bbox, date = "2024-07-15"),
               "datetime=2024-07-15T00:00:00Z/2024-07-15T23:59:59Z")

  # Date range as character vector
  expect_match(stacit(bbox, date = c("2024-01-01", "2024-01-31")),
               "datetime=2024-01-01T00:00:00Z/2024-01-31T23:59:59Z")

  # Date objects
  expect_match(stacit(bbox, date = as.Date(c("2024-03-01", "2024-03-15"))),
               "datetime=2024-03-01T00:00:00Z/2024-03-15T23:59:59Z")
})

test_that("stacit datetime appears in all split queries for anti-meridian", {
  skip_if_not_installed("sds")

  result <- stacit(c(179, 181, -16, -15), date = "2024-06-15")

  expect_length(result, 2)
  # Both queries should have the same datetime
  expect_match(result[1], "datetime=2024-06-15T00:00:00Z/2024-06-15T23:59:59Z")
  expect_match(result[2], "datetime=2024-06-15T00:00:00Z/2024-06-15T23:59:59Z")
})

test_that("stacit uses sensible default datetime", {
  skip_if_not_installed("sds")

  result <- stacit(c(140, 145, -40, -35))

  # Should have a datetime parameter (default is today?)
  expect_match(result, "datetime=")
  # Should be a valid ISO interval format
  expect_match(result, "datetime=\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z/\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z")
})

test_that("stacit rejects invalid date ranges via .datehandler", {
  skip_if_not_installed("sds")

  # End before start should error
  expect_error(stacit(c(140, 145, -40, -35), date = c("2024-02-01", "2024-01-15")))
})


test_that("stacit includes date in URL", {
  skip_if_not_installed("sds")

  result <- stacit(c(140, 145, -40, -35), date = "2024-06")
  expect_match(result, "datetime=2024-06-01T00:00:00Z/2024-06-30T23:59:59Z")
})

test_that("stacit accepts various date formats", {
  skip_if_not_installed("sds")

  bbox <- c(140, 145, -40, -35)

  # Year only
  expect_match(stacit(bbox, date = "2024"),
               "datetime=2024-01-01T00:00:00Z/2024-12-31T23:59:59Z")

  # Year-month
  expect_match(stacit(bbox, date = "2024-03"),
               "datetime=2024-03-01T00:00:00Z/2024-03-31T23:59:59Z")

  # Full date
  expect_match(stacit(bbox, date = "2024-07-15"),
               "datetime=2024-07-15T00:00:00Z/2024-07-15T23:59:59Z")

  # Date range as character vector
  expect_match(stacit(bbox, date = c("2024-01-01", "2024-01-31")),
               "datetime=2024-01-01T00:00:00Z/2024-01-31T23:59:59Z")

  # Date objects
  expect_match(stacit(bbox, date = as.Date(c("2024-03-01", "2024-03-15"))),
               "datetime=2024-03-01T00:00:00Z/2024-03-15T23:59:59Z")
})

test_that("stacit date appears in all split queries for anti-meridian", {
  skip_if_not_installed("sds")

  result <- stacit(c(179, 181, -16, -15), date = "2024-06-15")

  expect_length(result, 2)

  expect_match(result[1], "datetime=2024-06-15T00:00:00Z/2024-06-15T23:59:59Z")
  expect_match(result[2], "datetime=2024-06-15T00:00:00Z/2024-06-15T23:59:59Z")
})

test_that("stacit rejects invalid date ranges", {
  skip_if_not_installed("sds")

  expect_error(stacit(c(140, 145, -40, -35), date = c("2024-02-01", "2024-01-15")))
})

# collections parameter
test_that("stacit uses default collection", {
  skip_if_not_installed("sds")

  result <- stacit(c(140, 145, -40, -35))
  expect_match(result, "collections=sentinel-2-c1-l2a")
})

test_that("stacit accepts custom collection", {
  skip_if_not_installed("sds")

  result <- stacit(c(140, 145, -40, -35), collections = "landsat-c2-l2")
  expect_match(result, "collections=landsat-c2-l2")
})

test_that("stacit collection appears in all anti-meridian split queries", {
  skip_if_not_installed("sds")

  result <- stacit(c(179, 181, -16, -15), collections = "cop-dem-glo-30")

  expect_length(result, 2)
  expect_match(result[1], "collections=cop-dem-glo-30")
  expect_match(result[2], "collections=cop-dem-glo-30")
})

# provider parameter
test_that("stacit uses earth-search by default", {
  skip_if_not_installed("sds")

  result <- stacit(c(140, 145, -40, -35))
  expect_match(result, "earth-search\\.aws\\.element84\\.com")
})

test_that("stacit accepts planetary computer provider", {
  skip_if_not_installed("sds")

  result <- stacit(c(140, 145, -40, -35),
                   provider = "https://planetarycomputer.microsoft.com/api/stac/v1/search")
  expect_match(result, "planetarycomputer\\.microsoft\\.com")
})

# limit parameter
test_that("stacit uses default limit of 1000", {
  skip_if_not_installed("sds")

  result <- stacit(c(140, 145, -40, -35))
  expect_match(result, "limit=1000")
})

test_that("stacit accepts custom limit", {
  skip_if_not_installed("sds")

  result <- stacit(c(140, 145, -40, -35), limit = 50)
  expect_match(result, "limit=50")
})

test_that("stacit limit appears in all anti-meridian split queries", {
  skip_if_not_installed("sds")

  result <- stacit(c(179, 181, -16, -15), limit = 250)

  expect_length(result, 2)
  expect_match(result[1], "limit=250")
  expect_match(result[2], "limit=250")
})

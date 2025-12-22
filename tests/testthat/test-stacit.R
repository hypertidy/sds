test_that("stacit handles anti-meridian crossing to the east (xmax > 180)", {

  # Extent that wraps past 180
  ll_over_extent <- c(178.990101891497, 181.08301, -16.0285566658563, -14.9406621354295)
  result <- stacit(ll_over_extent)

  expect_length(result, 2)

  # First query should go from xmin to 180

  expect_match(result[1], "bbox=178\\.99[^,]*,-16[^,]*,180,-14")

  # Second query should wrap to -180 side
  expect_match(result[2], "bbox=-180,-16[^,]*,-178")
})

test_that("stacit handles anti-meridian crossing to the west (xmin < -180)", {

  result <- stacit(c(-181, -179, -16, -15))

  expect_length(result, 2)

  # One query on the -180 side
  expect_match(result[1], "bbox=-180,-16,-179,-15")

  # One query wrapping to the +180 side
  expect_match(result[2], "bbox=179,-16,180,-15")
})

test_that("stacit returns single query when within valid lon range", {

  result <- stacit(c(-180, -175, -16, -15))

  expect_length(result, 1)
  expect_match(result, "bbox=-180,-16,-175,-15")
})

test_that("stacit returns single query for normal extent", {

  result <- stacit(c(140, 145, -40, -35))

  expect_length(result, 1)
  expect_match(result, "bbox=140,-40,145,-35")
})


test_that("stacit handles extent exactly at -180 boundary", {
  skip_if_not_installed("sds")

  result <- stacit(c(-180, -170, -20, -10))
  expect_length(result, 1)
})

test_that("stacit handles extent exactly at 180 boundary", {
  skip_if_not_installed("sds")

  result <- stacit(c(170, 180, -20, -10))
  expect_length(result, 1)
})

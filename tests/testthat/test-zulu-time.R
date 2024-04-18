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

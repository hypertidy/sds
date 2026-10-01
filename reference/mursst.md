# MURSST (GHRSST) sst Zarr source

This is used a lot of noisy fanfare about why everyone must move to Zarr
in the cloud. It's really big, daily netcdf blended/observation/model
data on a 36000x18000 grid, a regular grid in -180, 180, -90, 90.

## Usage

``` r
mursst_zarr(band = 0)

mursst_time(time = NULL)
```

## Arguments

- band:

  a band number (defaults to 0, which is 2002-06-01)

- time:

  a time value to pick, see Details

## Value

a string, a dsn for Zarr MURSST

## Details

This zarr and every other one I've found is unuseably out of date. It
seems like this source doesn't go past "2020-01-21" or band 6443, don't
know why that is.

## Examples

``` r
mursst_zarr()
#> [1] "ZARR:\"/vsis3/mur-sst/zarr\":/analysed_sst:0"
mursst_time("2019-10-08")
#> [1] "ZARR:\"/vsis3/mur-sst/zarr\":/analysed_sst:6338"
```

# Sea ice CDR (climate data record) url

The first subdataset 'cdr_seaice_conc' is the one you want, but also
included are "cdr_seaice_conc_interp_spatial_flag",
"cdr_seaice_conc_interp_temporal_flag", "cdr_seaice_conc_qa_flag",
"cdr_seaice_conc_stdev", "raw_bt_seaice_conc", "raw_nt_seaice_conc" and
"surface_type_mask"

## Usage

``` r
seaice_cdr(date, hemisphere = c("south", "north"), vsi = TRUE)
```

## Arguments

- date:

  date or or string YYYY-mm-dd

- hemisphere:

  north or south

- vsi:

  in GDAL url form

## Value

string with path to CDR sea ice netcdf file

## Details

I've had mixed success setting subdataset and having these return with
the correct orientation.

## Examples

``` r
seaice_cdr()
#> [1] "/vsicurl/https://noaadata.apps.nsidc.org/NOAA/G02202_V6/south/daily/2026/sic_pss25_20260923_am2_v06r00.nc"
```

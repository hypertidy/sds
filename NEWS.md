# sds dev

* GEDTM sources list is a dog's breakfast so have removed for now. 

* Western anti-meridian queries are now handled (Issue #12). Removed unused asset from stacit(). 

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

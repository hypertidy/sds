# swiss topo GDAL tile index

`swisstopo.gti.gpkg` is a Geopackage vector polygon index of the Swisstopo from


https://www.swisstopo.admin.ch/en/height-model-swissalti3d#Additional-information

This is a tile index in GTI GDAL format, a vector layer of the polygon bbox of each of the GeoTIFF tiles with metadata to fully described the mosaic. 

The index file itself is 14Mb, Geopackage is uncompressed. 

in python with xarray use

```python
xarray.open_dataset("GTI:/vsicurl/https://github.com/hypertidy/sds/raw/refs/heads/main/data-raw/swisstopo.gti.gpkg", engine = "rasterio")
```

in R with terra

```R
r <- rast("GTI:/vsicurl/https://github.com/hypertidy/sds/raw/refs/heads/main/data-raw/swisstopo.gti.gpkg")

#e.g. iconic area
plot(crop(r, ext(c(2615548L, 2618548L, 1090170L, 1093170L))))
```


or, use the Geopackage as an actual vector layer, it has one column 'location' with /vsicurl links to the tile GeoTIFFs. 


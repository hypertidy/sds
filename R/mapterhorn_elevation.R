
## this is rendered VRT for GDAL >= 3.14
.mapterhorn_calc_raster_vrt <- '<VRTDataset rasterXSize="2097152" rasterYSize="2097152">
  <SRS dataAxisToSRSAxisMapping="1,2">PROJCS["WGS 84 / Pseudo-Mercator",GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4326"]],PROJECTION["Mercator_1SP"],PARAMETER["central_meridian",0],PARAMETER["scale_factor",1],PARAMETER["false_easting",0],PARAMETER["false_northing",0],UNIT["metre",1,AUTHORITY["EPSG","9001"]],AXIS["Easting",EAST],AXIS["Northing",NORTH],EXTENSION["PROJ4","+proj=merc +a=6378137 +b=6378137 +lat_ts=0 +lon_0=0 +x_0=0 +y_0=0 +k=1 +units=m +nadgrids=@null +wktext +no_defs"],AUTHORITY["EPSG","3857"]]</SRS>
  <GeoTransform> -2.0037508342789244e+07,  1.9109257071294063e+01,  0.0000000000000000e+00,  2.0037508342789244e+07,  0.0000000000000000e+00, -1.9109257071294063e+01</GeoTransform>
  <VRTRasterBand dataType="Float32" band="1" subClass="VRTDerivedRasterBand">
    <SimpleSource name="X[1]">
      <SourceFilename relativeToVRT="0">/vsicurl/https://download.mapterhorn.com/planet.pmtiles</SourceFilename>
      <SourceBand>1</SourceBand>
      <SrcRect xOff="0" yOff="0" xSize="2097152" ySize="2097152" />
      <DstRect xOff="0" yOff="0" xSize="2097152" ySize="2097152" />
    </SimpleSource>
    <SimpleSource name="X[2]">
      <SourceFilename relativeToVRT="0">/vsicurl/https://download.mapterhorn.com/planet.pmtiles</SourceFilename>
      <SourceBand>2</SourceBand>
      <SrcRect xOff="0" yOff="0" xSize="2097152" ySize="2097152" />
      <DstRect xOff="0" yOff="0" xSize="2097152" ySize="2097152" />
    </SimpleSource>
    <SimpleSource name="X[3]">
      <SourceFilename relativeToVRT="0">/vsicurl/https://download.mapterhorn.com/planet.pmtiles</SourceFilename>
      <SourceBand>3</SourceBand>
      <SrcRect xOff="0" yOff="0" xSize="2097152" ySize="2097152" />
      <DstRect xOff="0" yOff="0" xSize="2097152" ySize="2097152" />
    </SimpleSource>
    <PixelFunctionType>expression</PixelFunctionType>
    <PixelFunctionArguments dialect="muparser" expression="(X[1] * 256 + X[2] + X[3] / 256) - 32768" />
  </VRTRasterBand>
  <OverviewList resampling="nearest">2 4 8 16 32 64 128 256 512 1024 2048 4096 8192</OverviewList>
</VRTDataset>'


#' Mapterhorn PMTiles raster elevation
#'
#' Rendered calc VRT that unpacks planet.pmtiles from Mapterhorn, a large collection of
#' regional elevation sources encoded in Terrarium Terrain RGB '(R*256 + G + B/256) - 32768'
#'
#' @param ... unused
#'
#' @returns VRT text string, useable by GDAL >= 3.14 with muparser support
#' @export
#'
#' @examples
#' writeLines(mapterhorn_elevation())
mapterhorn_elevation <- function(...) {
  .mapterhorn_calc_raster_vrt
}


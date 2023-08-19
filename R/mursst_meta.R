mursst_meta <- function() {
  '
  "type": "group",
  "driver": "Zarr",
  "name": "/",
  "attributes": {
    "Conventions": "CF-1.7",
    "Metadata_Conventions": "Unidata Observation Dataset v1.0",
    "acknowledgment": "Please acknowledge the use of these data with the following statement:  These data were provided by JPL under support by NASA MEaSUREs program.",
    "cdm_data_type": "grid",
    "comment": "MUR = \"Multi-scale Ultra-high Resolution\"",
    "creator_email": "ghrsst@podaac.jpl.nasa.gov",
    "creator_name": "JPL MUR SST project",
    "creator_url": "http://mur.jpl.nasa.gov",
    "date_created": "20200124T010755Z",
    "easternmost_longitude": 180,
    "file_quality_level": 3,
    "gds_version_id": "2.0",
    "geospatial_lat_resolution": 0.00999999977648258209,
    "geospatial_lat_units": "degrees north",
    "geospatial_lon_resolution": 0.00999999977648258209,
    "geospatial_lon_units": "degrees east",
    "history": "created at nominal 4-day latency; replaced nrt (1-day latency) version.",
    "id": "MUR-JPL-L4-GLOB-v04.1",
    "institution": "Jet Propulsion Laboratory",
    "keywords": "Oceans > Ocean Temperature > Sea Surface Temperature",
    "keywords_vocabulary": "NASA Global Change Master Directory (GCMD) Science Keywords",
    "license": "These data are available free of charge under data policy of JPL PO.DAAC.",
    "metadata_link": "http://podaac.jpl.nasa.gov/ws/metadata/dataset/?format=iso&shortName=MUR-JPL-L4-GLOB-v04.1",
    "naming_authority": "org.ghrsst",
    "netcdf_version_id": "4.1",
    "northernmost_latitude": 90,
    "platform": "Terra, Aqua, GCOM-W, MetOp-A, MetOp-B, Buoys/Ships",
    "processing_level": "L4",
    "product_version": "04.1",
    "project": "NASA Making Earth Science Data Records for Use in Research Environments (MEaSUREs) Program",
    "publisher_email": "ghrsst-po@nceo.ac.uk",
    "publisher_name": "GHRSST Project Office",
    "publisher_url": "http://www.ghrsst.org",
    "references": "http://podaac.jpl.nasa.gov/Multi-scale_Ultra-high_Resolution_MUR-SST",
    "sensor": "MODIS, AMSR2, AVHRR, in-situ",
    "source": "MODIS_T-JPL, MODIS_A-JPL, AMSR2-REMSS, AVHRRMTA_G-NAVO, AVHRRMTB_G-NAVO, iQUAM-NOAA/NESDIS, Ice_Conc-OSISAF",
    "southernmost_latitude": -90,
    "spatial_resolution": "0.01 degrees",
    "standard_name_vocabulary": "NetCDF Climate and Forecast (CF) Metadata Convention",
    "start_time": "20200116T090000Z",
    "stop_time": "20200116T090000Z",
    "summary": "A merged, multi-sensor L4 Foundation SST analysis product from JPL.",
    "time_coverage_end": "20200116T210000Z",
    "time_coverage_start": "20200115T210000Z",
    "title": "Daily MUR SST, Final product",
    "uuid": "27665bc0-d5fc-11e1-9b23-0800200c9a66",
    "westernmost_longitude": -180
  },
  "dimensions": [
    {
      "name": "lat",
      "full_name": "/lat",
      "size": 17999,
      "type": "HORIZONTAL_Y",
      "direction": "NORTH",
      "indexing_variable": "/lat"
    },
    {
      "name": "lon",
      "full_name": "/lon",
      "size": 36000,
      "type": "HORIZONTAL_X",
      "direction": "EAST",
      "indexing_variable": "/lon"
    },
    {
      "name": "time",
      "full_name": "/time",
      "size": 6443,
      "type": "TEMPORAL",
      "indexing_variable": "/time"
    }
  ],
  "arrays": {
    "lat": {
      "datatype": "Float32",
      "dimensions": [
        "/lat"
      ],
      "dimension_size": [
        17999
      ],
      "block_size": [
        17999
      ],
      "attributes": {
        "axis": "Y",
        "comment": "none",
        "long_name": "latitude",
        "valid_max": 90,
        "valid_min": -90
      },
      "unit": "degrees_north"
    },
    "lon": {
      "datatype": "Float32",
      "dimensions": [
        "/lon"
      ],
      "dimension_size": [
        36000
      ],
      "block_size": [
        36000
      ],
      "attributes": {
        "axis": "X",
        "comment": "none",
        "long_name": "longitude",
        "valid_max": 180,
        "valid_min": -180
      },
      "unit": "degrees_east"
    },
    "time": {
      "datatype": "Int64",
      "dimensions": [
        "/time"
      ],
      "dimension_size": [
        6443
      ],
      "block_size": [
        5
      ],
      "attributes": {
        "axis": "T",
        "calendar": "proleptic_gregorian",
        "comment": "Nominal time of analyzed fields",
        "long_name": "reference time of sst field"
      },
      "unit": "days since 2002-06-01 09:00:00"
    },
    "analysed_sst": {
      "datatype": "Int16",
      "dimensions": [
        "/time",
        "/lat",
        "/lon"
      ],
      "dimension_size": [
        6443,
        17999,
        36000
      ],
      "block_size": [
        6443,
        100,
        100
      ],
      "attributes": {
        "comment": "\"Final\" version using Multi-Resolution Variational Analysis (MRVA) method for interpolation",
        "long_name": "analysed sea surface temperature",
        "standard_name": "sea_surface_foundation_temperature",
        "valid_max": 32767,
        "valid_min": -32767
      },
      "unit": "kelvin",
      "offset": 298.149999999999977,
      "scale": 0.00100000000000000002
    },
    "analysis_error": {
      "datatype": "Int16",
      "dimensions": [
        "/time",
        "/lat",
        "/lon"
      ],
      "dimension_size": [
        6443,
        17999,
        36000
      ],
      "block_size": [
        6443,
        100,
        100
      ],
      "attributes": {
        "comment": "none",
        "long_name": "estimated error standard deviation of analysed_sst",
        "valid_max": 32767,
        "valid_min": 0
      },
      "unit": "kelvin",
      "offset": 0,
      "scale": 0.0100000000000000002
    },
    "mask": {
      "datatype": "Int8",
      "dimensions": [
        "/time",
        "/lat",
        "/lon"
      ],
      "dimension_size": [
        6443,
        17999,
        36000
      ],
      "block_size": [
        6443,
        100,
        100
      ],
      "attributes": {
        "comment": "mask can be used to further filter the data.",
        "flag_masks": [1, 2, 4, 8, 16],
        "flag_meanings": "1=open-sea, 2=land, 5=open-lake, 9=open-sea with ice in the grid, 13=open-lake with ice in the grid",
        "flag_values": [1, 2, 5, 9, 13],
        "long_name": "sea/land field composite mask",
        "source": "GMT \"grdlandmask\", ice flag from sea_ice_fraction data",
        "valid_max": 31,
        "valid_min": 1
      }
    },
    "sea_ice_fraction": {
      "datatype": "Int8",
      "dimensions": [
        "/time",
        "/lat",
        "/lon"
      ],
      "dimension_size": [
        6443,
        17999,
        36000
      ],
      "block_size": [
        6443,
        100,
        100
      ],
      "attributes": {
        "comment": "ice data interpolated by a nearest neighbor approach.",
        "long_name": "sea ice area fraction",
        "source": "EUMETSAT OSI-SAF, copyright EUMETSAT",
        "standard_name": "sea ice area fraction",
        "valid_max": 100,
        "valid_min": 0
      },
      "unit": "fraction (between 0 and 1)",
      "offset": 0,
      "scale": 0.0100000000000000002
    }
  }
}
'
}

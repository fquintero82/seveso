# read file seveso.p03.hdf
# find the water surface elevation rasters
# create raster maps from them, find the spatial reference system in the attributes of the hdf
# use library terra to create rasters
# add installers to the libraries if they are not installed
# use library hdf5r instead of rhdf5



if (!requireNamespace("hdf5r", quietly = TRUE)) install.packages("hdf5r")
if (!requireNamespace("terra", quietly = TRUE)) install.packages("terra")
if (!requireNamespace("sf", quietly = TRUE)) install.packages("sf")
library('hdf5r')
library('terra')
library('sf')

hdf_file <- "seveso.p03.hdf"

# Open HDF file using hdf5r
h5 <- H5File$new(hdf_file, mode = "r")

# List all groups and datasets in the HDF file
hdf_contents <- h5$ls(recursive = TRUE)

# Find datasets related to water surface elevation (adjust pattern as needed)
wse_datasets <- subset(hdf_contents, grepl("water_surface_elevation", name, ignore.case = TRUE))

# Read and create raster maps
rasters <- list()
for (i in seq_len(nrow(wse_datasets))) {
  dset_path <- paste0(wse_datasets$group[i], "/", wse_datasets$name[i])
  data <- h5[[dset_path]]$read()
  # Assuming data is a matrix; adjust dimensions if needed
  rasters[[dset_path]] <- rast(data)
}

# Find spatial reference system in attributes
attrs <- h5[[paste0(wse_datasets$group[1], "/", wse_datasets$name[1])]]$attr_names
crs_str <- NULL
if ("crs" %in% attrs) {
  crs_str <- h5[[paste0(wse_datasets$group[1], "/", wse_datasets$name[1])]]$attr_open("crs")$read()
  for (r in rasters) {
    crs(r) <- crs_str
  }
} else {
  warning("CRS attribute not found in HDF file.")
}

# Example: plot the first raster
if (length(rasters) > 0) {
  plot(rasters[[1]], main = names(rasters)[1])
}

h5$close()
# Example: plot the first raster
if (length(rasters) > 0) {
  plot(rasters[[1]], main = names(rasters)[1])
}

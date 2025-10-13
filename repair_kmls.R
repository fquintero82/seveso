library(sf)
f = paste0('conf4/conf4Contour Band Polygons', 1:11, '.shp')
f2 = Sys.glob('conf4/*.gpkg')
f = c(f, f2)
for (i in 1:length(f)) {
  #writeVector(f[i], sprintf('conf4/%s.kml',i), overwrite=TRUE)
  sf::st_write(obj = read_sf(f[i]), dsn = sprintf('conf4/%s.kml',i))
}


library(terra)
f ='conf4/Depth (PF 11).vrt'
r11 = rast(f)

f ='conf4/Depth (PF 12).vrt'
r12 = rast(f)

f ='conf4/Depth (PF 13).vrt'
r13 = rast(f)

f ='conf4/Depth (PF 14).vrt'
r14 = rast(f)

r11[is.na(r11[])] = 0
r12[is.na(r12[])] = 0
r13[is.na(r13[])] = 0
r14[is.na(r14[])] = 0

r12 = r12 + r11
r13 = r13 + r12
r14 = r14 + r13
r12[r12[] <= 0] = NA
r13[r13[] <= 0] = NA
r14[r14[] <= 0] = NA
writeRaster(r12, 'conf4/r12b.tif', overwrite=TRUE)
writeRaster(r13, 'conf4/r13b.tif', overwrite=TRUE)
writeRaster(r14, 'conf4/r14b.tif', overwrite=TRUE)
r12[r12[] > 0] = 1
r13[r13[] > 0] = 1
r14[r14[] > 0] = 1
p12 = as.polygons(r12, dissolve=TRUE)
p13 = as.polygons(r13, dissolve=TRUE)
p14 = as.polygons(r14, dissolve=TRUE)
writeVector(p12, 'conf4/p12b.gpkg', overwrite=TRUE)
writeVector(p13, 'conf4/p13b.gpkg', overwrite=TRUE)
writeVector(p14, 'conf4/p14b.gpkg', overwrite=TRUE)
# loads shapefiles, removes unwanted columns and copies into the working folder
# for further processing in python

require(rgdal)
shapes <- list.files("output", pattern=".shp")
for(shp in shapes){
  shp <- substr(shp, 1, nchar(shp) - 4)
  shp_poly <- readOGR("output", shp)
  shp_poly <- subset(shp_poly, select="lcm_class")
  writeOGR(shp_poly, "C:/ArcMapWorkingFolder/model_input", shp, driver="ESRI Shapefile")
}
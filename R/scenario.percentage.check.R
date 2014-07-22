# calculate the percentage of the whole landscape that each of the percentage
# class shapefiles actually end up be - purpose is to test if there are any
# problem scenarios where the percentages classes are too far off
rm(list=ls())
require(rgdal)
require(rgeos)
files <- list.files("output", pattern=".shp")
test.res <- data.frame(area=numeric(0), stringsAsFactors=FALSE)
for(f in files){
  f <- substr(f, 1, nchar(f)-4)
  lcm <- readOGR("output", f)
  area <- gArea(lcm)
  test.res[f,1] <- area
}

lcm <- readOGR("E:/IFM_R/data/shapes", "lcm")
lcm.hab <- lcm[lcm$INTCODE %in% c(1,2,3,4,5,6,8,9,10,11),] 
lcm.hab$area_ha <- gArea(lcm.hab, byid=TRUE)/10000
lcm.hab <- lcm.hab[lcm.hab$area_ha >= 0.02,]
area  <- gArea(lcm.hab)
test.res["lcm",1] <- area

for(i in 1:nrow(test.res)){
  test.res[i, 2] <- test.res[i, 1] / test.res["lcm", 1] * 100
}
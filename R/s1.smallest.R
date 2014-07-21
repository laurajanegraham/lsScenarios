# Habitat patches are removed in order of their size (smallest first)

s1 <- function(lcm.hab) {
  lcm.hab <- lcm.hab[order(lcm.hab$area_ha),]
  lcm.hab$cumsum <- cumsum(lcm.hab$area_ha)
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.1*sum(lcm.hab$area_ha),], 
           "data/shapes/scenarios", "s3_90_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.2*sum(lcm.hab$area_ha),], 
           "data/shapes/scenarios", "s3_80_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.3*sum(lcm.hab$area_ha),], 
           "data/shapes/scenarios", "s3_70_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.4*sum(lcm.hab$area_ha),], 
           "data/shapes/scenarios", "s3_60_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.5*sum(lcm.hab$area_ha),], 
           "data/shapes/scenarios", "s3_50_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.6*sum(lcm.hab$area_ha),], 
           "data/shapes/scenarios", "s3_40_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.7*sum(lcm.hab$area_ha),], 
           "data/shapes/scenarios", "s3_30_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.8*sum(lcm.hab$area_ha),], 
           "data/shapes/scenarios", "s3_20_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.9*sum(lcm.hab$area_ha),], 
           "data/shapes/scenarios", "s3_10_perc", driver="ESRI Shapefile")
  
}

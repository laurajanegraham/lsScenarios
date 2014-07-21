# Habitat patches are removed in order of their size (smallest first)

s2 <- function(lcm.hab) {
  lcm.hab <- lcm.hab[order(lcm.hab$area_ha, decreasing=TRUE),]
  lcm.hab$cumsum <- cumsum(lcm.hab$area_ha)
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.1*sum(lcm.hab$area_ha),], 
           "output", "s2_90_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.2*sum(lcm.hab$area_ha),], 
           "output", "s2_80_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.3*sum(lcm.hab$area_ha),], 
           "output", "s2_70_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.4*sum(lcm.hab$area_ha),], 
           "output", "s2_60_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.5*sum(lcm.hab$area_ha),], 
           "output", "s2_50_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.6*sum(lcm.hab$area_ha),], 
           "output", "s2_40_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.7*sum(lcm.hab$area_ha),], 
           "output", "s2_30_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.8*sum(lcm.hab$area_ha),], 
           "output", "s2_20_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.9*sum(lcm.hab$area_ha),], 
           "output", "s2_10_perc", driver="ESRI Shapefile")
  
}

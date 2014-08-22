# function samples a landscape of suitable habitat and stops when it has removed the set proportion
# of suitable habitat patches. Weights patches by type - grassland more vulnerable.
s3 <- function(lcm.hab) {
  load("data/habitat.rarity.gb.rda")
  lcm.gb.stat$rarity <- row.names(lcm.gb.stat)
  lcm.hab@data <- data.frame(lcm.hab@data, lcm.gb.stat[match(lcm.hab@data$lcm_class, 
                                                                         lcm.gb.stat$code),])
  lcm.hab <- lcm.hab[order(as.numeric(lcm.hab$rarity)),]
  lcm.hab@data <- subset(lcm.hab@data, select=c("code", "area_ha"))
  names(lcm.hab@data)  <- c("lcm_class", "area_ha")
  lcm.hab$cumsum <- cumsum(lcm.hab$area_ha)
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.1*sum(lcm.hab$area_ha),], 
           "output", "s3_90_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.2*sum(lcm.hab$area_ha),], 
           "output", "s3_80_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.3*sum(lcm.hab$area_ha),], 
           "output", "s3_70_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.4*sum(lcm.hab$area_ha),], 
           "output", "s3_60_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.5*sum(lcm.hab$area_ha),], 
           "output", "s3_50_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.6*sum(lcm.hab$area_ha),], 
           "output", "s3_40_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.7*sum(lcm.hab$area_ha),], 
           "output", "s3_30_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.8*sum(lcm.hab$area_ha),], 
           "output", "s3_20_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.9*sum(lcm.hab$area_ha),], 
           "output", "s3_10_perc", driver="ESRI Shapefile")
}
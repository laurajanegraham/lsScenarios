# function samples a landscape of suitable habitat and stops when it has removed the set proportion
# of suitable habitat patches. Weights patches by type - grassland more vulnerable.
s4 <- function(lcm.hab) {
  load("data/habitat.rarity.nott.rda")
  lcm.stat$rarity <- row.names(lcm.stat)
  lcm.hab@data <- data.frame(lcm.hab@data, lcm.stat[match(lcm.hab@data$lcm_class, 
                                                                         lcm.stat$code),])
  lcm.hab <- lcm.hab[order(as.numeric(lcm.hab$rarity)),]
  lcm.hab@data <- subset(lcm.hab@data, select=c("code", "area_ha"))
  names(lcm.hab@data)  <- c("lcm_class", "area_ha")
  lcm.hab$cumsum <- cumsum(lcm.hab$area_ha)
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.1*sum(lcm.hab$area_ha),], 
           "output", "s4_90_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.2*sum(lcm.hab$area_ha),], 
           "output", "s4_80_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.3*sum(lcm.hab$area_ha),], 
           "output", "s4_70_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.4*sum(lcm.hab$area_ha),], 
           "output", "s4_60_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.5*sum(lcm.hab$area_ha),], 
           "output", "s4_50_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.6*sum(lcm.hab$area_ha),], 
           "output", "s4_40_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.7*sum(lcm.hab$area_ha),], 
           "output", "s4_30_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.8*sum(lcm.hab$area_ha),], 
           "output", "s4_20_perc", driver="ESRI Shapefile")
  writeOGR(lcm.hab[lcm.hab$cumsum >= 0.9*sum(lcm.hab$area_ha),], 
           "output", "s4_10_perc", driver="ESRI Shapefile")
}
# function samples a landscape of suitable habitat and stops when it has removed the set proportion
# of suitable habitat patches. Weights patches by type - grassland more vulnerable.
s4 <- function(lcm.hab) {
  require(dplyr)
  total.area <- sum(lcm.hab$area_ha)
  for(p in seq(10, 90, 10)){
    lcm.stat <- ddply(lcm.hab@data, .(lcm_class), summarise, area_ha=sum(area_ha))
    lcm.stat <- arrange(lcm.stat, -area_ha)
    lcm.stat$rarity <- row.names(lcm.stat)
    lcm.hab@data <- data.frame(lcm.hab@data, lcm.stat[match(lcm.hab@data$lcm_class, 
                                                            lcm.stat$lcm_class),])
    lcm.hab <- lcm.hab[order(as.numeric(lcm.hab$rarity)),]
    lcm.hab@data <- subset(lcm.hab@data, select=c("lcm_class", "area_ha"))
    names(lcm.hab@data)  <- c("lcm_class", "area_ha")
    lcm.hab$cumsum <- cumsum(lcm.hab$area_ha)
    lcm.hab <- lcm.hab[lcm.hab$cumsum >= 0.1*total.area,]
    writeOGR(lcm.hab, "output", paste0("s4_", 100-p,"_perc"), driver="ESRI Shapefile")
  }
  
}
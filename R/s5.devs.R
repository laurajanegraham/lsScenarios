# Habitat patches are removed in order of their proximity to developments. At
# each iteration, the removed habitat patches are added to the developments
# layer and the distance recalculated. This creates the effect of developments
# as a contagion.

s5 <- function(lcm.hab) {
  devs <- readOGR("data", "developments", verbose=FALSE)
  total.area <- sum(lcm.hab$area_ha)
  
  for(x in seq(90, 10, by=-10)){
    dist <- gDistance(devs, lcm.hab, byid=TRUE)
    lcm.hab$dist <- apply(dist, 1, min)
    lcm.hab <- lcm.hab[order(lcm.hab$dist),]
    lcm.hab$cumsum <- cumsum(lcm.hab$area_ha)
    
    if(x==90){
      devs <- lcm.hab[lcm.hab$cumsum < 0.1*total.area,] # update developments to be everything removed so far
    }
    else{
      devs <- rbind(devs, lcm.hab[lcm.hab$cumsum < 0.1*total.area,]) # update developments to be everything removed so far
    }
    lcm.hab <- lcm.hab[lcm.hab$cumsum >= 0.1*total.area,]
    writeOGR(lcm.hab, "output", paste0("s5_", x, "_perc"), driver="ESRI Shapefile")
  } 
}
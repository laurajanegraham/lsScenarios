require(dplyr)
require(rgdal)
require(rgeos)

# get landscape info from shapefiles into a list
scenario.groups <- c("s1", "s2", "s3", "s4", "s5")
scenario.ls <- list()
for(s in scenario.groups){
  files <- list.files("output", pattern=glob2rx(paste0(s, "*.shp")))
  ls.df <- list()
  for(f in files){
    f <- substr(f, 1, nchar(f) - 4)
    ls <- readOGR("output", f)
    ls <- ls@data
    ls$perc <- substr(f, 4,5)
    ls.df[[f]] <- ls
  }
  scenario.ls[[s]] <- do.call("rbind", ls.df)
}

save(scenario.ls, file="output/scenario.ls.rda")

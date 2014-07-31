require(plyr)
require(rgdal)
require(rgeos)

# # get landscape info from shapefiles into a list - currently commented out so doesn't run on source()
# scenario.groups <- c("s1", "s2", "s3", "s4", "s5")
# scenario.ls <- list()
# for(s in scenario.groups){
#   files <- list.files("output", pattern=glob2rx(paste0(s, "*.shp")))
#   ls.df <- list()
#   for(f in files){
#     f <- substr(f, 1, nchar(f) - 4)
#     ls <- readOGR("output", f)
#     ls <- ls@data
#     ls$perc <- 100 - as.numeric(substr(f, 4,5))
#     ls.df[[f]] <- ls
#   }
#   scenario.ls[[s]] <- do.call("rbind", ls.df)
# }
# 
# save(scenario.ls, file="output/scenario.ls.rda")

# create mean patch size plots
mps.plots <- function(){
  require(ggplot2)
  require(RColorBrewer)
  load("output/scenario.ls.rda")
  scenario.ls <- llply(scenario.ls, function(x) ddply(x, .(perc), summarize, mps = round(mean(area_ha), 2)))
  scenario.ls <- do.call("rbind", scenario.ls)
  scenario.ls$scenario <- paste0("Scenario ", toupper(substr(row.names(scenario.ls), 1,2)))
  ggplot(data=scenario.ls, aes(x=perc, y=mps, group = scenario, colour = scenario)) +
    geom_line() +
    geom_point(size=3) + 
    scale_color_manual(values = brewer.pal(length(unique(scenario.ls$scenario)), "Dark2"))
}

# create patch density plots
pd.plots <- function(){
  require(ggplot2)
  load("output/scenario.ls.rda")
  scenario.ls <- llply(scenario.ls, function(x) ddply(x, .(perc), summarize, mps = length(area_ha) / sum(area_ha)))
  scenario.ls <- do.call("rbind", scenario.ls)
  scenario.ls$scenario <- paste0("Scenario ", toupper(substr(row.names(scenario.ls), 1,2)))
  ggplot(data=scenario.ls, aes(x=perc, y=mps, group = scenario, colour = scenario)) +
    geom_line() +
    geom_point( size=3, shape=21, fill="white") + 
    scale_color_manual(values = brewer.pal(length(unique(scenario.ls$scenario)), "Dark2"))
}

# create habitat barplots - coverage by habitat type
pd.plots <- function(){
  require(ggplot2)
  load("output/scenario.ls.rda")
  lcm.lookup <- read.csv("E:/IFM_R/data/lcm_lookup.csv")
  scenario.ls <- llply(scenario.ls, function(x) ddply(x, .(perc, lcm_class), summarize, area_ha = sum(area_ha)))
  scenario.ls <- do.call("rbind", scenario.ls)
  scenario.ls$scenario <- paste0("Scenario ", toupper(substr(row.names(scenario.ls), 1,2)))
  scenario.ls <- merge(scenario.ls, lcm.lookup, by.x="lcm_class", by.y="code")
  scenario.ls <- subset(scenario.ls, select=c(perc, area_ha, type, scenario))
  
  ggplot(scenario.ls, aes(x=perc, y=area_ha, fill=scenario)) + 
    geom_bar(stat="identity", position=position_dodge()) +
    facet_wrap(~type, ncol=2, scales="free_y") + 
    scale_fill_manual(values = brewer.pal(length(unique(scenario.ls$scenario)), "Dark2"))

}

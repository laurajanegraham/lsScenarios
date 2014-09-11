require(plyr)
require(rgdal)
require(rgeos)

# get landscape info from shapefiles into a list
scenario.groups <- c("s1", "s2", "s3", "s4", "s5", "s6")
scenario.ls <- list()
for(s in scenario.groups){
  files <- list.files("output", pattern=glob2rx(paste0(s, "*.shp"))) 
  ls.df <- list()
  for(f in files){
    f <- substr(f, 1, nchar(f) - 4)
    ls <- readOGR("output", f)
    ls$area_ha <- gArea(ls, byid=TRUE)/10000
    ls <- ls@data
    ls <- subset(ls, lcm_class != 16) # S6 has shapes including the freshwater - these polys aren't being used.
    ls$perc <- 100 - as.numeric(substr(f, 4,5))
    ls.df[[f]] <- ls
  }
  scenario.ls[[s]] <- do.call("rbind", ls.df)
}

save(scenario.ls, file="../IFM_R/results/scenario.ls.rda")

# create mean patch size plots
require(ggplot2)
load("../IFM_R/results/scenario.ls.rda")
scenario.ls <- llply(scenario.ls, function(x) ddply(x, .(perc), summarize, mps = round(mean(area_ha), 2)))
scenario.ls <- do.call("rbind", scenario.ls)
scenario.ls$Scenario <- paste0("Scenario ", toupper(substr(row.names(scenario.ls), 1,2)))
ggplot(data=scenario.ls, aes(x=perc, y=mps, group = Scenario, colour = Scenario)) +
  geom_line() +
  geom_point(size=3) + 
  scale_color_brewer(type="qual", palette = 3) + 
  labs(x = "% habitat loss", y = "Mean patch size (ha)") + 
  theme_classic()


# create patch density plots
require(ggplot2)
load("E:/IFM_R/results/scenario.ls.rda")
scenario.ls <- llply(scenario.ls, function(x) ddply(x, .(perc), summarize, pd = length(area_ha) / sum(area_ha)))
scenario.ls <- do.call("rbind", scenario.ls)
scenario.ls$Scenario <- paste0("Scenario ", toupper(substr(row.names(scenario.ls), 1,2)))
ggplot(data=scenario.ls, aes(x=perc, y=mps, group = Scenario, color = Scenario)) +
  geom_line() +
  geom_point(size=3) + 
  scale_color_brewer(type="qual", palette = 3) + 
  labs(x = "% habitat loss", y = "Patch density") + 
  theme_classic()


# create habitat barplots - coverage by habitat type
load("E:/IFM_R/results/scenario.ls.rda")
lcm.lookup <- read.csv("E:/IFM_R/data/lcm_lookup.csv")
scenario.ls <- llply(scenario.ls, function(x) ddply(x, .(perc, lcm_class), summarize, area_ha = sum(area_ha)))
scenario.ls <- do.call("rbind", scenario.ls)
scenario.ls$Scenario <- paste0("Scenario ", toupper(substr(row.names(scenario.ls), 1,2)))
scenario.ls <- merge(scenario.ls, lcm.lookup, by.x="lcm_class", by.y="code")
scenario.ls <- subset(scenario.ls, select=c(perc, area_ha, type, Scenario))

ggplot(scenario.ls, aes(x=perc, y=area_ha, fill=Scenario)) + 
  geom_bar(stat="identity", position=position_dodge()) +
  facet_wrap(~type, ncol=2, scales="free_y") + 
  scale_fill_brewer(type="qual", palette = 3) +
  labs(x = "% habitat loss", y = "Total area (ha)") + 
  theme_classic() +  theme(strip.background=element_blank())


library(shiny)
library(dplyr)
library(leaflet)
library(raster)

rootdir <- 'C:/Users/gr556/Documents/GitHub/Vulcan_v3_map_data/data/tifs/'
  
for (f in list.files(rootdir)) {
  infile  <- paste0(rootdir,f)
  sector <- gsub(".mn.2011.tif","",f)
  
  r <- raster(infile)
  crs(r) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  r <- log(r)
  eval(parse(text=paste0("r.",sector," <- r")))  
}

vals <- getValues(r.total)
vals <- vals[which(!is.na(vals) & !is.infinite(vals) & vals > -10)]
colors   <- colorRampPalette(c("navy","blue","white","red","darkred"))
pal <- colorNumeric(colors(101), domain=vals,
                      na.color = "transparent")

groups <- c("Total","Residential","Commercial","Industrial","Electricity production",
            "Onroad mobile","Offroad mobile","Airports","Railroads","Ports and Shipping","Cement production")

# create the leaflet map  
vulcan.map <- 
  leaflet() %>% 
  addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addProviderTiles(providers$NASAGIBS.ModisTerraTrueColorCR) %>%
  addProviderTiles(providers$OpenStreetMap.BlackAndWhite) %>%
  addProviderTiles(providers$OpenStreetMap) %>%
  addProviderTiles(providers$Stamen) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  
  addRasterImage(r.total, colors=pal, project = T, opacity=0.5,
                 maxBytes=16*38595600, group = "Total") %>%
  addRasterImage(r.residential, colors=pal, project = T, opacity=0.5,
                 maxBytes=16*38595600, group = "Residential") %>%
  addRasterImage(r.commercial, colors=pal, project = T, opacity=0.5,
                 maxBytes=16*38595600, group = "Commercial") %>%
  addRasterImage(r.industrial, colors=pal, project = T, opacity=0.5,
                 maxBytes=16*38595600, group = "Industrial") %>%
  addRasterImage(r.elec_prod, colors=pal, project = T, opacity=0.5,
                 maxBytes=16*38595600, group = "Electricity production") %>%
  addRasterImage(r.onroad, colors=pal, project = T, opacity=0.5,
                 maxBytes=16*38595600, group = "Onroad mobile") %>%
  addRasterImage(r.nonroad, colors=pal, project = T, opacity=0.5,
                 maxBytes=16*38595600, group = "Offroad mobile") %>%
  addRasterImage(r.airport, colors=pal, project = T, opacity=0.5,
                 maxBytes=16*38595600, group = "Airports") %>%
  addRasterImage(r.rail, colors=pal, project = T, opacity=0.5,
                 maxBytes=16*38595600, group = "Railroads") %>%
  addRasterImage(r.cmv, colors=pal, project = T, opacity=0.5,
                 maxBytes=16*38595600, group = "Ports and Shipping") %>%
  addRasterImage(r.cement, colors=pal, project = T, opacity=0.5,
                 maxBytes=16*38595600, group = "Cement production") %>%
  
  
  addLegend(pal = pal, values = vals,
                      title = "log(tC") %>%
  addLayersControl(baseGroups=c("ESRI Grey Canvas", "ESRI Nat Geo", "NASA Modis Terra True Color",
                                "OSM B/W","OSM","Stamen","Stamen Toner",), overlayGroups=groups)
    
save(vulcan.map, file="C:/Users/gr556/Documents/GitHub/Vulcan_v3_map/data/vulcan.map.RData")

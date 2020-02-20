library(shiny)
library(dplyr)
library(leaflet)
library(raster)

shinyServer(function(input, output) {
  
  r <- raster('C:/Users/gr556/Documents/GitHub/Vulcan_v3_map/data/tifs/total.mn.2011.tif')
  crs(r) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  r <- log(r)
  
  # Create enlarged city boundaries for map
  bounds <- extent(r)
  lng1   <- extent(r)[1]-5
  lng2   <- extent(r)[2]+5
  lat1   <- extent(r)[3]-5
  lat2   <- extent(r)[4]+5
  
  vals <- getValues(r)
  vals <- vals[which(!is.na(vals) & !is.infinite(vals) & vals > -10)]
  colors   <- colorRampPalette(c("navy","blue","green3","yellow","orange","darkred"))
  colors   <- colorRampPalette(c("navy","blue","white","red","darkred"))
  pal <- colorNumeric(colors(101), domain=vals,
                      na.color = "transparent")

  # create the leaflet map  
  output$vulcan_map <- renderLeaflet({
    leaflet() %>% 
    #setView(-100, 35, zoom = 5) %>%
    addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
    #addTiles(urlTemplate = 'https://github.com/gsroest/Vulcan_v3_map/tree/master/data/tiles/total/{z}/{x}/{y}.png',
    #         group="Total", 
    #         options=tileOptions(opacity=0.7, minZoom=0, maxZoom=10, tms = T)) %>%
    addRasterImage(r, colors=pal, project = T, opacity=0.5,
                   maxBytes=16*38595600) %>%
    addLegend(pal = pal, values = vals,
              title = "log(tC") %>%
    addLayersControl(baseGroups=c("ESRI Grey Canvas"), overlayGroups="Total")
    
  })
})
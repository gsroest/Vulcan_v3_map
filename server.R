library(shiny)
library(dplyr)
library(leaflet)
library(raster)

shinyServer(function(input, output) {
  
  #r <- raster('./data/total.mn.2011.tif')
  #crs(r) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #r <- log(r)
  
  # Create enlarged city boundaries for map
  #bounds <- extent(r)
  #lng1   <- extent(r)[1]-5
  #lng2   <- extent(r)[2]+5
  #lat1   <- extent(r)[3]-5
  #lat2   <- extent(r)[4]+5
  
  #vals <- getValues(r)
  #vals <- vals[which(!is.na(vals) & !is.infinite(vals) & vals > -10)]
  #colors   <- colorRampPalette(c("navy","blue","green3","yellow","orange","darkred"))
  #colors   <- colorRampPalette(c("navy","blue","white","red","darkred"))
  #pal <- colorNumeric(colors(101), domain=vals,
  #                    na.color = "transparent")

  # create the leaflet map  
  output$vulcan_map <- renderLeaflet({
    leaflet() %>% 
    addProviderTiles(providers$Esri.WorldGrayCanvas) # %>%
    #addRasterImage(r, colors=pal, project = T, opacity=0.5,
    #               maxBytes=16*38595600) %>%
    #addLegend(pal = pal, values = vals,
    #          title = "log(tC")
    
  })
})
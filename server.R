library(shiny)
library(dplyr)
library(leaflet)
library(raster)

shinyServer(function(input, output) {
  
  load('./vulcan.map.RData')
  
  # create the leaflet map  
  output$vulcan_map <- renderLeaflet({
    vulcan.map  
  })
})
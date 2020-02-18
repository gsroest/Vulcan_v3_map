library(shiny)
library(leaflet)

navbarPage("Vulcan v3.0", id="main",
           tabPanel("Map", leafletOutput("vulcan_map", height=1000)),
           tabPanel("Read Me",includeMarkdown("README.md")))

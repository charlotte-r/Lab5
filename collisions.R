#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(spData)
library(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("Traffic Crashes by Hour"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("hour",
                  "Hour: ",
                  min = 0,
                  max = 24,
                  value = 12,
                  step = 1,
                  sep= "")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("map")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

myicon <- makeIcon(
  iconUrl = "http://pngimg.com/uploads/dot/dot_PNG33.png",
  iconWidth = 6, iconHeight = 6,
  iconAnchorX = 22, iconAnchorY = 94)

  output$map <- renderLeaflet({
    attach(COL_i)
    filter(COL_i, crash_hour == input$hour) %>%  # subset by hour
      leaflet() %>%
      addTiles() %>%
      setView(-87.6293, 41.9094, zoom=10) %>%
      addMarkers(icon=myicon)

  })

}

# Run the application
shinyApp(ui = ui, server = server)




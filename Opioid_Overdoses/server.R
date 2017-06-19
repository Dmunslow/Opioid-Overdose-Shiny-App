#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
require(shiny)
require(googleVis)

#Load overdose data 
overdose_states <- read.csv("./overdose_processed_states.csv", header = T)
overdose_US <- read.table("./overdoses_us.txt",header = T)

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
    displayYear <- reactive({
        input$Year
    })
    
    output$year <- renderText({
        paste("Opioid Overdose Deaths in ", displayYear())
    })
 
    output$cloropleth <- renderGvis({
        data <- overdose_states[Year == displayYear(),]
        
        gvisGeoChart(overdose_all, "State", "Crude_Rate", options = list(region="US",
                                                                         displayMode = "regions",
                                                                         resolution = "provinces",
                                                                          width = 500, height = 400))
    })
  
})

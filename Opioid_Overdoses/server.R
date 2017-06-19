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
overdose_states <- read.csv("./data/overdose_processed_states.csv", header = T)
overdose_US <- read.table("./data/overdoses_us.txt",header = T)



library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
    displayYear <- reactive({
        input$Year
    })
    
    output$year <- renderText({
        paste("Opioid Overdose Deaths in ", displayYear())
    })
    
    df_subset <- reactive({
        data <- overdose_states[overdose_states$Year == input$Year,]
        data <- overdose_states[overdose_states$Multiple_Cause_of_death == input$odType,]
        return(data)
    })
    
    stat_type <- reactive(({
        input$statType
    }))
 
    output$cloropleth <- renderGvis({
        data <- df_subset()
        stat <- stat_type()
        gvisGeoChart(data, "State", stat, options = list(region="US",
                                                             displayMode = "regions",
                                                             resolution = "provinces",
                                                             width = 500, height = 400))
    })
  
})

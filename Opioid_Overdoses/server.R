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
require(plotly)


#Load overdose data 
overdose_states <- read.csv("./data/overdose_processed_states.csv", header = T)
overdose_US <- read.csv("./data/overdose_processed_US.csv",header = T)


library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
    # function to store stat type
    displayYear <- reactive({
        input$Year
    })
    stat_type <- reactive(({
        input$statType
    }))
    
    # Reactive label for the choropleth
    output$mapYear <- renderText({
        stat <- stat_type()
        if(stat == "PCT_of_Total_Deaths"){
            paste("Opioid Overdoses as % of all Deaths in ", displayYear())
        } else if (stat == "Crude_Rate"){
            paste("Opioid Overdose Death Rate in ", displayYear())
        } else if (stat == "Deaths") {
            paste("Total Opioid Overdose Deaths in ", displayYear())
        }
    })
    
    # Reactive label for the data table
    output$tableYear <- renderText({
        paste("Opioid Overdose Statistics for the Year ", displayYear())
    })
    
    # reactive function that subsets the data based on slider and radio buttons
    df_subset <- reactive({
        data <- overdose_states[(overdose_states$Year == displayYear() & overdose_states$Multiple_Cause_of_death == input$odType),]
        return(data)
    })
    
   
    
    # Reactive Choropleth map that changes based on radio button/slider selections
    output$choropleth <- renderGvis({
        data <- df_subset()
        stat <- stat_type()
        gvisGeoChart(data, "State", stat, options = list(region="US",
                                                             displayMode = "regions",
                                                             resolution = "provinces",
                                                            width = 500, height = 300))
    })
    
    ### Create table that outputs data based on selected radio buttons
    output$myTable <- renderGvis({
        data <- df_subset()
        gvisTable(data, options= list( width=550,height= 275), formats = list(Year = "####"))         
    })
  
})

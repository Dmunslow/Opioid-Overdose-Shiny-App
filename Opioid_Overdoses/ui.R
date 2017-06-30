#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  #titlePanel("Opioid Overdose Deaths in the United States 2000-2015"),
  
  headerPanel("Opioid Overdose Deaths in the US 2000-2015"),
  sidebarPanel(
      
      
      radioButtons("odType", "Choose type of Opioid Overdose:",
                   c("All Opioids" = "All Opioids", 
                     "Heroin" = "Heroin",
                     "Other Opioids (includes Prescription)" = "Other opioids",
                     "Other Synthetic Narcotics (includes fentanyl)" = "Other synthetic narcotics",
                     "Methadone" = "Methadone" )),
      radioButtons("statType", "Choose Statistic:",
                         c("Total Deaths" = "Deaths", 
                           "Death Rate (per 100,000)" = "Death_Rate",
                           "As Percentage of All Deaths" = "Pct_of_Total_Deaths")),
      h3(tableOutput("tableYear")),
      htmlOutput('myTable')
      ),
      
  mainPanel(
     h2("How to Use this App"),
     p("This app uses data from the Centers For Disease Control to demonstrate how the opioid crisis in the US has evolved over time.
        Users may select the type of opioid overdose, as well as the statistic to be displayed in the side panel.
        The year can be changed using the slider, or a time sequence can viewed by pressing the play button.
        Users may see the data being mapped for each state by hovering over the state or by referencing the table in the side panel.
        More information on this epidemic can be found by following the link below the map."),
     
     sliderInput("Year", "Select Year to be displayed:",
                  min = 2000, max =2015, value = 2000, step = 1,
                  animate = TRUE, sep = "", width = 500 ),
     h3(textOutput("mapYear")),
     htmlOutput("choropleth"),
     helpText( p("Note: States which appear green on the map represent unavailable data for that year/overdose type"),
               a("Centers for Disease Control and Prevention: Opioid Overdoses", 
                 href = "https://www.cdc.gov/drugoverdose/index.html", target ="_blank" ))
  )
  
 
))

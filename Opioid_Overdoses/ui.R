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
                           "Death Rate (per 100,000)" = "Crude_Rate",
                           "As Percentage of All Deaths" = "PCT_of_Total_Deaths")),
      h3(tableOutput("tableYear")),
      htmlOutput('myTable')
      ),
      
  mainPanel(
      sliderInput("Year", "Select Year to be displayed:",
                  min = 2000, max =2015, value = 2000, step = 1,
                  animate = TRUE, sep = "", width = 500 ),
     h3(textOutput("mapYear")),
     htmlOutput("choropleth")
  )
  
 
))

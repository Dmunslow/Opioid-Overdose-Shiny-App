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
shinyUI(pageWithSidebar(
  
  # Application title
  #titlePanel("Opioid Overdose Deaths in the United States 2000-2015"),
  
  headerPanel("Opioid Overdose Geochart - United states"),
  sidebarPanel(
      sliderInput("Year", "Select Year to be displayed:",
                  min = 2000, max =2015, value = 2000, step = 1,
                  animate = TRUE )
  ),
 
  mainPanel(
     h3(textOutput("year")),
     htmlOutput("cloropleth")
  )
  
 
))

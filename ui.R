library(shiny)
library(plotly)
library(ggplot2)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
    titlePanel("Canada Unemployment Rate from 2012 to 2017"),
    sidebarLayout(
        sidebarPanel(
            h1("Move the month slider!"),
         
            sliderInput("slider1", "Slide Me!", 0, 12, 0, step =1)
    
        
    ),
    mainPanel(
       
        wellPanel(
        conditionalPanel(condition = "output.test1 == false",
                         plotlyOutput("plot0", width = "100%") ),
        conditionalPanel(condition = "output.test1 == true",
                         plotOutput("plot1", width = "100%"))
       
    )
      
    )
   )
))

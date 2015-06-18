
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(data.table)

## Load the data and useful lists
load("data/data.Rda")
load("data/countyList.Rda")



shinyUI(fluidPage(
  titlePanel("2013 EPA Ozone Data Analysis"),
  

  # Sidebar with a slider input for number of bins
  fluidRow(
    column(2,
           selectInput("countyNumber", 
                       "County Code", 
                       choices = c("All", countyList), 
                       selected = "All")
    ),
    column(2,
           selectInput("siteNumber", 
                       "Site Number", 
                       choices = c("--"), 
                       selected = "--")
    ),
    column(2,
           selectInput("sortBy", 
                       "Sort by", 
                       choices = c("Ozone", "AQI"), 
                       selected = "Ozone")
    ), 
    column(2,
           selectInput("order", 
                       "Order", 
                       choices = c("Increasing", "Decreasing"), 
                       selected = "Increasing")
    )
    
    
  ),
  fluidRow(
    dataTableOutput(outputId="dataTable")
  ) ,

  
))

library(shiny)
library(leaflet)
library(data.table)

## Load the data and useful lists
load("data/data.Rda")
load("data/stateList.Rda")



shinyUI(fluidPage(
  titlePanel("2013 EPA Ozone Data Analysis"),
  

  # Sidebar with a slider input for number of bins
  mainPanel(
      fluidRow(  
        column(12,
               leafletOutput(outputId = "map" , height = 350, width = "140%"))
        ),
      br(),
      fluidRow(
        fluidRow(
          
          column(2,
                 selectInput("stateCode", 
                             "State Code", 
                             choices = c("All", stateList), 
                             selected = "All")
          ),
          
          column(3,
                 selectInput("countyNumber", 
                             "County Code", 
                             choices = c("--"), 
                             selected = "--")
          ),
          column(3,
                 selectInput("siteNumber", 
                             "Site Number", 
                             choices = c("--"), 
                             selected = "--")
          ),
          column(3,
                 selectInput("sortBy", 
                             "Sort by", 
                             choices = c("Ozone", "AQI"), 
                             selected = "Ozone")
          ), 
          column(3,
                 selectInput("order", 
                             "Order", 
                             choices = c("Increasing", "Decreasing"), 
                             selected = "Increasing")
          )
        ),
       column(12, 
          dataTableOutput(outputId="dataTable")
       ) 
    )
  )
)
)

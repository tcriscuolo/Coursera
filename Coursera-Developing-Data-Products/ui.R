library(shiny)
library(leaflet)
library(data.table)

## Load the data and useful lists
load("data/data.Rda")
load("data/stateList.Rda")



shinyUI(fluidPage(
  titlePanel("2013 EPA Ozone Data Analysis"),
  br(),
  h5((strong("App description"))),
  
  p("The data set used in this app is from", 
    a("EPA air data", href = "http://www.epa.gov/airdata/"), 
    ". The data set used is the Ozone daily data set from the year of 2013", br(), 
       "more information about the data set can be found ",
    a("here", href = "http://aqsdr1.epa.gov/aqsweb/aqstmp/airdata/FileFormats.html"), 
    ". The main porpouse of this app is to display the mean value of", br() ," Ozone and Airquality Index
       across the year of 2013 collected by each station each day. Station number are not unique,
       each station ", br(), "has a state and a county code, a state code is unique, 
        but a county code is unique only inside a state, then inside a county a", br(),  "station number is unique"),
  br(),
  
  h5("How to use the App ?"),
     p("The app consists of displaying the points in a map and in a table.", 
       "There are five interective buttons to crontrol the result that is displayed,
       following is the description of each button.",
        br(),
      strong("State: "), "Select a state code, the starting value is all, therefore it will desplay all
       stations in the data set on the table, but it will display nothing on the map because
       it is too slow to plot all the stations, after selecting a state number, 
       it will display only stattion from that state and it will unlock the county 
       button to select a county code", br(),
      strong("County: "), "Select a county code, each state has a different set of county code, 
      the list of county displayed depends on the current selected state. After selecting a count, 
      the map and table will display only station on that county and it will unlock the site button", br(),
      strong("Station: "), "Select a station id, the station list depends on the current selected state
       and county", br(),
      strong("Sorty by: "), "Sort the data by Ozone mean value or AQI mean value for the year of 2013", br(),
      strong("Order: "), "Changes the order by incriasing or decreasing"), br(),
      "Check the code on my",
        a("github",  href = "https://github.com/tcriscuolo/Coursera/tree/master/Coursera-Developing-Data-Products"),
  
  h3("The App:"), 
  
  
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
                             "State", 
                             choices = c("All", stateList), 
                             selected = "All")
          ),
          
          column(2,
                 selectInput("countyNumber", 
                             "County", 
                             choices = c("--"), 
                             selected = "--")
          ),
          column(2,
                 selectInput("siteNumber", 
                             "Site", 
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

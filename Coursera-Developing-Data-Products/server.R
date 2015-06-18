
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(data.table)
library(leaflet)


load(file = "data/data.Rda") # load the data set as Rda, much faster than loading from a csv file
load("data/countyList.Rda")



shinyServer(function(input, output, clientData, session) {
  observe({
    curCounty <- input$countyNumber
    if(curCounty != "All") {
      siteList <- sort(data[, County.Code, Site.Num][County.Code == 1, Site.Num])
      updateSelectInput(session, "siteNumber", choices = c("All", siteList))
    } else {
      updateSelectInput(session, "siteNumber", choices = "--")
    }
  })
  
  output$dataTable <- renderDataTable({
    curCounty <- input$countyNumber
    curSite <- input$siteNumber
    curSort <- input$sortBy
    curOrd <- switch(input$order, "Increasing" = FALSE, "Decreasing" = TRUE)
    if(curCounty == "All") {
      ifelse(curSort == "Ozone", 
                    return(data[, ][order(OZONE, decreasing = curOrd)]),
                    return(data[, ][order(AQI, decreasing = curOrd)]))
    } else {
      if(curSite == "All") {
        ifelse(curSort == "Ozone", 
               return(data[County.Code == curCounty, ][order(OZONE, decreasing = curOrd)]),
               return(data[County.Code == curCounty, ][order(AQI, decreasing = curOrd)]))
      } else {
        ifelse(curSort == "Ozone", 
               return(data[County.Code == curCounty & Site.Num == curSite, ][order(OZONE, decreasing = curOrd)]),
               return(data[County.Code == curCounty & Site.Num == curSite, ][order(AQI, decreasing = curOrd)]))
      }
    }
    
  }, options = list(searching = FALSE))
  
 

})

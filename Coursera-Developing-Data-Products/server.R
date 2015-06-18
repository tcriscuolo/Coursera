
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(data.table)
library(leaflet)
library(scales)


load("data/data.Rda") # load the data set as Rda, much faster than loading from a csv file
load("data/stateList.Rda")

shinyServer(function(input, output, clientData, session) {
  observe({
    curState <- input$stateCode
    if(curState != "All") {
      countyList <- sort(data[, State.Code, County.Code][State.Code == curState, County.Code])
      updateSelectInput(session, "countyNumber", choices = c("All", countyList))
    } else {
      updateSelectInput(session, "countyNumber", choices = "--")
    }   
  })
  
  
  observe({
    # On selecting a state 
    # it will be able to select a county
    # After selecting na county
    # it will be able to select a site 
    
    curCounty <- input$countyNumber
    
    if(curCounty == "--") 
      return ()
    # The state has already been selected 
    # so it is different of All
    curState <- input$stateCode
    
    if(curCounty != "All") {
      siteList <- sort(data[State.Code == curState & County.Code == curCounty, ][, Site.Num])
      updateSelectInput(session, "siteNumber", choices = c("All", siteList))
    } else {
      updateSelectInput(session, "siteNumber", choices = "--")
    }   
  })
  
 
  
  dataInput <- reactive({
    # Returns the data table 
    # according to the parameters 
    curState <- input$stateCode
    curCounty <- input$countyNumber
    curSite <- input$siteNumber
    curSort <- input$sortBy
    curOrd <- switch(input$order, "Increasing" = FALSE, "Decreasing" = TRUE)
    
    if(curState == "All") {
      ifelse(curSort == "Ozone", 
             return(data[, ][order(OZONE, decreasing = curOrd)]),
             return(data[, ][order(AQI, decreasing = curOrd)])) 
    }
    
    if(curCounty == "All") {
      ifelse(curSort == "Ozone", 
             return(data[State.Code == curState, ][order(OZONE, decreasing = curOrd)]),
             return(data[State.Code == curState, ][order(AQI, decreasing = curOrd)]))
    } else {
      if(curSite == "All") {
        ifelse(curSort == "Ozone", 
               return(data[State.Code == curState &
                             County.Code == curCounty, ][order(OZONE, decreasing = curOrd)]),
               return(data[State.Code == curState & 
                             County.Code == curCounty, ][order(AQI, decreasing = curOrd)]))
      } else {
        ifelse(curSort == "Ozone", 
               return(data[State.Code == curState & 
                             County.Code == curCounty &
                             Site.Num == curSite, ][order(OZONE, decreasing = curOrd)]),
               return(data[State.Code == curState & 
                             County.Code == curCounty & 
                             Site.Num == curSite, ][order(AQI, decreasing = curOrd)]))
      }
    }
    
  })
  
  # Render the data table 
  output$dataTable <- renderDataTable({
    return (dataInput())
    
  }, options = list(searching=FALSE, ordering=FALSE, paging=TRUE, search = FALSE))

  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles(
        urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
        attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
      ) %>%
      setView(lng = -90.85, lat = 48.45, zoom = 3)
  })
  
  observe({
    curState <- input$stateCode
    # it will not plot all sites because it is too slow
    if(curState == "All") {
      leafletProxy("map", deferUntilFlush = FALSE) %>% 
        clearMarkers()
      return()
    } 
    
    data <- dataInput()
    coordVect <- as.data.frame(data[, Longitude, Latitude])
    addr <- as.data.frame(data[ , Address])
    leafletProxy("map", deferUntilFlush = FALSE) %>% 
                        clearMarkers() %>%
                        addMarkers(lng=coordVect$Longitude, lat=coordVect$Latitude)
    
  })
})

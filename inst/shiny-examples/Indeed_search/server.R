library(shiny)
library(group6project)
library(leaflet)
library(tidyverse)
library(lubridate)

shinyServer(function(input, output) {

 #load data as a reactive event

  indeed_data <- eventReactive(input$goIndeed, {
    #read indeed data
    readRDS(file = input$file1)
  })

  cities_coord <- eventReactive(input$goCities, {
    #read cities_coord data
    readRDS( file = input$file2)
    })

    output$Map <-  renderLeaflet({
      indeed_data %>%
        map_ready_df(cities_coord) %>%
        indeed_map()
    })

})

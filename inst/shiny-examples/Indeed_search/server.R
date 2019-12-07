library(shiny)
library(group6project)
library(leaflet)
library(tidyverse)
library(lubridate)

shinyServer(function(input, output) {

 #load data as a reactive event

  datasets <- reactiveValues()
    #read indeed data
    observeEvent (input$go, {datasets$indeed_data <- readRDS(input$file1$datapath)
    })
    #read cities_coord data
    observeEvent (input$go, {datasets$cities_coord <- readRDS(input$file2$datapath)
    })

  output$Map <-  renderLeaflet({

    datasets[["indeed_data"]] %>%
      map_ready_df(datasets[["cities_coord"]]) %>%
      indeed_map()
    })
})

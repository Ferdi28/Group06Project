library(shiny)
library(group6project)
library(leaflet)
library(tidyverse)

shinyServer(function(input, output) {

 #load data as a reactive event

  datasets <- reactiveValues()
    #read indeed data
    observeEvent (input$go, {datasets$indeed_data <- readRDS(input$file1$datapath)
    })

    observeEvent(input$choose,{
      datasets$indeed_data <- datasets$indeed_data %>%
        filter(category %in% mytext$text)
        })

    mytext <- reactiveValues()

    observeEvent(input$category, {
    mytext$text <- (list(paste(input$category)))
    })

  output$Map <-  renderLeaflet({

    datasets[["indeed_data"]] %>%
      indeed_map()
    })

  })

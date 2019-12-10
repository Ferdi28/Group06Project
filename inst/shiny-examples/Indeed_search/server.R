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
      datasets$indeed_data2 <- datasets$indeed_data %>%
        filter(category %in% mytext$text)
        })

    mytext <- reactiveValues()

    observeEvent(input$category, {
    mytext$text <- c(as.character(input$category))
    })

    maps <- reactiveValues()

  observeEvent(input$map,{
   maps$map <- if (input$map == "Map With All Job Types"){
      output$Map <-  renderLeaflet({

        datasets[["indeed_data"]] %>%
          indeed_map()
      })
      } else if (input$map == "Map With Selected Categories"){
        output$Map <-  renderLeaflet({

          datasets[["indeed_data2"]] %>%
            indeed_map()
    })
      }
  })

  })

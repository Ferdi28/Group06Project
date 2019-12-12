library(shiny)
library(group6project)
library(leaflet)
library(tidyverse)

shinyServer(function(input, output) {

  #make Leaflet output change in size based on user preferences
  output$leaf=renderUI({
    leafletOutput('map', width = "100%", height = input$Height)
  })

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
  #read indeed data
  observeEvent (input$go, {datasets$indeed_data <- readRDS(input$file1$datapath)
  })
  #create new indeed data frame based on user filter choice
  observeEvent(input$choose,{
    datasets$indeed_data2 <- datasets$indeed_data %>%
      filter(category %in% mytext$text)
  })

  mytext <- reactiveValues()
  #create a reactive character list of filters to use for map
  observeEvent(input$category, {
    mytext$text <- c(as.character(input$category))
  })

  maps <- reactiveValues()

  observeEvent(input$map,{
    #create a different map based on the choice of the user
    maps$map <- if (input$map == "Map With All Job Types"){
      output$map <-  renderLeaflet({

        datasets[["indeed_data"]] %>%
          indeed_map()
      })
    } else if (input$map == "Map With Selected Categories"){
      output$map <-  renderLeaflet({

        datasets[["indeed_data2"]] %>%
          indeed_map()
      })
    }
  })

})

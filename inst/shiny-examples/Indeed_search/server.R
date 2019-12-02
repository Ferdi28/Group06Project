library(shiny)
library(ptds2019hw4g06)
library(tidyverse)
library(lubridate)

shinyServer(function(input, output) {

        #reactive function for Pi and CPU time
        simulated_pi <- reactive({
          estimate_pi(input$B, input$seed)[["estimated_pi"]]
    })
        simulated_time <- reactive({
          system.time(estimate_pi(input$B, input$seed))["elapsed"]*1000
        })

    output$plot <- renderPlot({
      plot(estimate_pi(input$B, input$seed))
    },
    width = 400, height = 400)

    output$time <- renderText({
        # extract the time of the execution
        paste("Elapsed time to estimate Pi in Milliseconds: ", simulated_time(),"If it is 0, the amount of time taken was negligible", sep ="\n")
    })

    output$pi <- renderText({
        # extract the estimated value
        paste0("Value of Estimated Pi : ",simulated_pi())
    })



})

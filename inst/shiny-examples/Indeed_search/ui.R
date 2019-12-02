library(shiny)

shinyUI(fluidPage(theme = "bootstrap.css",

    titlePanel("Pi Estimation"),

    sidebarLayout(

        sidebarPanel(



            numericInput("seed", label = "Choose a value for seed", value = 10),

            sliderInput("B", label = "Choose a number below", min = 1, max = 1000000, value = 5000)

        ),

        mainPanel(

            plotOutput("plot"),

            verbatimTextOutput("pi"),

            verbatimTextOutput("time")
        )
    )
))

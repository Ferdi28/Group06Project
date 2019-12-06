library(shiny)

shinyUI(fluidPage(theme = "bootstrap.css",

    titlePanel("Indeed Job Map"),

    sidebarLayout(

        sidebarPanel(

        ),

        mainPanel(

            plotOutput("Map"),
        )
    )
))

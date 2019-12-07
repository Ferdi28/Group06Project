library(shiny)

shinyUI(fluidPage(theme = "bootstrap.css",

    titlePanel("Indeed Job Map"),

    sidebarLayout(

        sidebarPanel( fileInput("file1", "Choose Indeed RDS File",
                                multiple = FALSE,
                                accept = c(".rds", ".RDS")),
                      actionButton(inputId = "goIndeed",
                                   label = "load first file"),
                      fileInput("file2", "Upload cities_coord providede with the package",
                                multiple = TRUE,
                                accept = c(".rds", ".RDS")),
                      actionButton(inputId = "goCities",
                                   label = "load second file")
        ),

        mainPanel(

            plotOutput("Map"),
        )
    )
))

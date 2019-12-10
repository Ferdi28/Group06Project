library(shiny)
library(group6project)
library(leaflet)
library(tidyverse)

shinyUI(fluidPage(theme = "bootstrap.css",

    titlePanel("Indeed Job Map"),

    sidebarLayout(

        sidebarPanel( fileInput("file1", "Choose Indeed RDS File",
                                multiple = FALSE,
                                accept = c(".rds", ".RDS")),

                      actionButton(inputId = "go",
                                   label = "Display Map with All The Jobs"),

                      selectInput(inputId = "category",
                                  choices = c("Marketing", "HR", "Data Science", "Consulting",
                                              "Accounting/Finance", "Business",
                                              "Management", "Economics", "Communication"),
                                  label = "select the desired job category",
                                  multiple = TRUE),
                      actionButton(inputId = "choose", label = "Confirm Choice")
        ),

        mainPanel(

            leafletOutput("Map"),
        )
    )
))

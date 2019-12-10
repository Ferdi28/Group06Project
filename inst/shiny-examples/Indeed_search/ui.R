library(shiny)
library(group6project)
library(leaflet)
library(tidyverse)

shinyUI(fluidPage(theme = "bootstrap.css",

    titlePanel("Indeed Job Map"),

    sidebarLayout(

        sidebarPanel(
            tags$div(
                HTML("Welcome to our Shiny App, here is a little guide to our app: </br>
                          </br> - Load our latest dataset of Indeed Job listings. An initial map with all the job listings in Switzerland will be displayed.
                               </br> - If you would like to filter by Job Category, make sure to select them and click the <strong>Confirm Choice </strong> button.
                              </br> - Selecting the <strong>Map With Selected Categories</strong> option will display the map with the filters you chose.
                              </br> - You can update the map with the filters by clicking on <strong>Confirm Choice</strong> and having the <strong>Map
                               With Selected Categories</strong> selected!
                               </br> - If you would like to go back to the initial map, simply select <strong>Map With All Job Types</strong> in <strong>Choose Map</strong>.")),
            fileInput("file1", "Choose Indeed RDS File",
                                multiple = FALSE,
                                accept = c(".rds", ".RDS")),
            tags$style(type="text/css",
                       ".shiny-output-error { visibility: hidden; }",
                       ".shiny-output-error:before { visibility: hidden; }"
            ),

                      actionButton(inputId = "go",
                                   label = "Load Data Base"),

                      selectInput(inputId = "category",
                                  choices = c("Marketing", "HR", "Data Science", "Consulting",
                                              "Accounting/Finance", "Business",
                                              "Management", "Economics", "Communication"),
                                  label = "Select The Desired Job Category",
                                  multiple = TRUE),

                      actionButton(inputId = "choose", label = "Confirm Choice"),

                      selectInput(inputId = "map",
                                  label = "Choose the Map",
                                  choices = c("Map With All Job Types", "Map With Selected Categories"))

        ),

        mainPanel(

            leafletOutput("Map"),
        )
    )
))

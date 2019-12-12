library(shiny)
library(group6project)
library(leaflet)
library(tidyverse)

shinyUI(fluidPage(theme = "bootstrap.css",

                  titlePanel("Indeed Job Map"),

                  sidebarLayout(

                      sidebarPanel(
                          tags$div(
                              HTML("<strong>Welcome to our Shiny App, here is a little guide to our app:</strong> </br></br>
                                 <strong>1.</strong> Load our latest dataset of Indeed Job listings. An initial map with all the job listings in Switzerland will be displayed.
                               </br> </br><strong>2.</strong> If you would like to filter by Job Category, make sure to select them and click the <strong>Confirm Choice </strong> button.
                              </br> </br> <strong>3.</strong> Selecting the <strong>Map With Selected Categories</strong> option will display the map with the filters you chose.
                              </br> </br> <strong>4.</strong> You can update the map with the filters by clicking on <strong>Confirm Choice</strong> and having the <strong>Map
                               With Selected Categories</strong> in <strong> Choose Map </strong> selected!
                               </br> </br><strong>5.</strong> If you would like to go back to the initial map,
                                simply select <strong>Map With All Job Types</strong> in <strong>Choose Map</strong>.</br></br>")),

                          fileInput("file1", "Choose Indeed RDS File",
                                    multiple = FALSE,
                                    accept = c(".rds", ".RDS")),

                      actionButton(inputId = "go",
                                   label = "Load Files/ Display Map"),



        ),
                          tags$style(type="text/css",
                                     ".shiny-output-error { visibility: hidden; }",
                                     ".shiny-output-error:before { visibility: hidden; }" ),

                          tags$style(
                              HTML(".sidebar { height: 90vh; overflow-y: auto; }" )),

                          actionButton(inputId = "go",
                                       label = "Load Data Base/Display Map"),
                          tags$div(
                              HTML("</br>")),

                          selectInput(inputId = "category",
                                      choices = c("Marketing", "HR", "Data Science", "Consulting",
                                                  "Accounting/Finance", "Business",
                                                  "Management", "Economics", "Communication"),
                                      label = "Select The Desired Job Category(ies)",
                                      multiple = TRUE),

                          actionButton(inputId = "choose", label = "Confirm Choice"),

                          tags$div(
                              HTML("</br>")),

                          selectInput(inputId = "map",
                                      label = "Choose the Map",
                                      choices = c("Map With All Job Types", "Map With Selected Categories")),
                          sliderInput("Height",
                                      "Height of Map in Pixels:",
                                      min = 100,
                                      max = 2000,
                                      value = 700)

                      ),

                      mainPanel(

                          uiOutput("leaf")
                      )
                  )
))

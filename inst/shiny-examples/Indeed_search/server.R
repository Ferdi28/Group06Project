library(shiny)
library(Group06Project)
library(leaflet)
library(tidyverse)
library(lubridate)

shinyServer(function(input, output) {

  indeed_data <- readRDS(file = here :: here("prepared Data/data_economics_consulting_communications.rds"))

    output$Map <-  renderLeaflet({
      indeed_data %>%
        map_ready_df() %>%
        indeed_map()
    },
    width = 500, height = 500)

})

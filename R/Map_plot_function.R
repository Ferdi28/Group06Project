library(tidyverse)
library(leaflet)
library(here)

#load useful data
indeed_data <- readRDS(file = here("prepared Data/data_economics_consulting_communications.rds"))
#function to create data set with coordinates

map_ready_df <- function(indeed_data, cities_coord){

   #load useful data
  cities_coord <- readRDS(file = here("prepared Data/cities_coord.rds"))
  #check if input is correct
  if (length(indeed_data$city) == 0){
    stop("Please ensure that the inputed data frame has columns named city, Latitude and Longitude")
  }

  if(length(cities_coord$city) == 0 | length(cities_coord$Latitude) == 0 | length(cities_coord$Longitude) == 0){
    stop("Please use the data frame of the city coordinates provided with this package")
  }
 # create data frame with coordinates
  indeed_data %>%
    merge( y=cities_coord, by = intersect("city", "city"), all.x=TRUE)
}


# leaflet function
indeed_map <- function(map_ready_df){
  #make sure input is from map_ready_df function
  if(length(map_ready_df$city) == 0 | length(map_ready_df$Latitude) == 0 | length(map_ready_df$Longitude) == 0 |
     length(map_ready_df$link) == 0 | length(map_ready_df$job_title) == 0)
    stop("Please use the output Data Frame from map_ready_df")
  #setting the radius
map_ready_df %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(clusterOption=markerClusterOptions(), label = map_ready_df$company,
             popup = paste(map_ready_df$job_title,"<br>","<a href=", map_ready_df$link,">link<a/>"))
}

#example
indeed_data %>% map_ready_df() %>% indeed_map()



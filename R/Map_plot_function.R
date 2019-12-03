library(tidyverse)
library(leaflet)


#function to create data set with coordinates

map_ready_df <- function(indeed_data, cities_coord){

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
map_ready_df %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(clusterOption=markerClusterOptions(), label = map_ready_df$company,
             popup = paste(map_ready_df$job_title,"<br>","<a href=", map_ready_df$link,">link<a/>"))
  }

#example
new_data_economics %>% map_ready_df() %>% indeed_map()




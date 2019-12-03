library(leaflet)


#function to filter correct data

map_ready_df <- function(indeed_data){
indeed_data %>%
  filter(between(Latitude,45.83203, 47.69732) & between(Longitude, 6.07544, 9.83723 ))
}

# leaflet
indeed_map <- function(map_ready_df){
map_ready_df %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(clusterOption=markerClusterOptions(), label = map_ready_df$company,
             popup = paste(map_ready_df$job_title,"<br>","<a href=", map_ready_df$link,">link<a/>"))
  }

#example
new_data_economics %>% map_ready_df() %>% indeed_map()


# a way to make an interractive map
locations_sf <- Map_ready_df %>%
  na.omit() %>%
  st_as_sf( coords = c("Longitude", "Latitude"), crs = 4326)
mapview(locations_sf)


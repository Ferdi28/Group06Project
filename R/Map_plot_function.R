#Create a swiss map object

world_map <- getMap(resolution = "high")

which(sapply(1:243, function(x) world_map@polygons[[x]]@ID) == "Switzerland")

switzerland <- world_map@polygons[[40]]@Polygons[[1]]@coords %>%
  as_tibble()
names(switzerland)[1]<-paste("Longitude")
names(switzerland)[2]<-paste("Latitude")

#filter correct data

map_ready_df <- new_data_economics %>%
  filter(between(Latitude,45.83203, 47.69732) & between(Longitude, 6.07544, 9.83723 ))

#Function

indeed_map <- function(switzerland,jobs_data_frame){

  ggplot() +
    labs( title = "Jobs location") +
      geom_polygon(data = switzerland,aes(x = Longitude, y = Latitude),color = "black", alpha = 0.3) +
      coord_fixed(1.3) +
        geom_point(data = jobs_data_frame, aes(Longitude,Latitude),color= "steelblue") +

    guides(size = guide_legend(order = 1),
           color = guide_legend(order = 2)) +

    theme(
      legend.key = element_rect(fill=NA),
      aspect.ratio = 0.75:0.75,
      panel.background = element_blank(),
      axis.line = element_line(colour = "black"),
      panel.border = element_rect(colour = "black", fill=NA, size=1))
}

indeed_map(switzerland, Map_ready_df)
Map_ready_df %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(clusterOption=markerClusterOptions(), label = Map_ready_df$company,
             popup = paste(Map_ready_df$job_title,"<br>","<a href=", Map_ready_df$link,">link<a/>"))





# a way to make an interractive map
locations_sf <- Map_ready_df %>%
  na.omit() %>%
  st_as_sf( coords = c("Longitude", "Latitude"), crs = 4326)
mapview(locations_sf)

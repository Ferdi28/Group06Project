ok <- data_economics_consulting_communications %>%
  group_by(city) %>%
  count() %>%
  na.omit() %>%
  as.data.frame()

ok %>% filter(n == 1)

ok1 <- ok %>% mutate_geocode(city)

saveRDS(ok1, file = "geo_data.rds")

register_google(key = "AIzaSyCGsH8T1ViNsk6pP0m5ustOJ17u4_dbCUU", write = TRUE)

#transform in character in order to join them
data_economics_consulting_communications <- data_economics_consulting_communications %>%
  mutate(city = as.character(city))

geo_data <- geo_data %>%
  mutate(city = as.character(city))
# join data
data_eco <- left_join(data_economics_consulting_communications, geo_data, by = "city")

data_eco <- data_eco[, - c(5,9)]
names(data_eco)[8]<-paste("Longitude")
names(data_eco)[9]<-paste("Latitude")

saveRDS(data_eco, file = "new_data_economics.rds")

# google map made some wrong calculations about some coordinates so we need to remove them
map_ready_df <- new_data_economics %>%
  filter(between(Latitude,45.83203, 47.69732) & between(Longitude, 6.07544, 9.83723 ))


#Create a swiss map object

world_map <- getMap(resolution = "high")

which(sapply(1:243, function(x) world_map@polygons[[x]]@ID) == "Switzerland")

switzerland <- world_map@polygons[[40]]@Polygons[[1]]@coords %>%
  as_tibble()
names(switzerland)[1]<-paste("Longitude")
names(switzerland)[2]<-paste("Latitude")


#Function

indeed_map0 <- function(switzerland,jobs_data_frame){

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

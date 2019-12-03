ok <- data_economics_consulting_communications %>% group_by(city) %>% count() %>% na.omit() %>% as.data.frame()

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

#' @title Indeed data frame
#' @description Create a data frame with indeed jobs and their corresponding latitiude longitude based on the city
#' \cr Please make sure u use the following code in order to have the data for the appropriate job category:\cr
#' - indeed_data <- readRDS(file = here :: here("prepared Data/#NameOfDesiredDataFrame.rds")) where the Data Frame comes from
#' the (prepared Data) folder
#' @param indeed_data A {Data Frame} scraped using the method from this package's authors
#' @param cities_coord A {Data Frame} with swiss cities names and respective Latitiude/Longitude, also provided with this package
#' @return A  \code Data Frame containing the following attributes:
#' \describe{
#'      \item{6 variables linked to job offers from indeed}
#'      \item{2 variables that contain Latitiude and Longitude for the job offers}
#' @import magrittr
#' @examples
#'map_ready_df(indeed_data)
#' @export
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

#' @title Indeed interactive Map
#' @description create an interactive map of the indeed data frame created with map_ready_df function.
#' It displays the job offers' location, its type and its external link to the indeed website
#' @param map_ready_df A {Data Frame} result of the output of the function of the same name
#' @return A  \code Plot containing the following attributes:
#' \describe{
#'      \item{Location for the job offer}
#'      \item{Type of job and link to indeed website}
#' @import tidyverse
#' @examples
#'indeed_data %>% map_ready_df() %>% indeed_map()
#' @export
# leaflet function
indeed_map <- function(map_ready_df){
  #make sure input is from map_ready_df function
  if(length(map_ready_df$city) == 0 | length(map_ready_df$Latitude) == 0 | length(map_ready_df$Longitude) == 0 |
     length(map_ready_df$link) == 0 | length(map_ready_df$job_title) == 0)
    stop("Please use the output Data Frame from map_ready_df")
map_ready_df %>%
  leaflet :: leaflet() %>%
  leaflet :: addTiles() %>%
  leaflet :: addMarkers(clusterOption=markerClusterOptions(), label = map_ready_df$company,
             popup = paste(map_ready_df$job_title,"<br>","<a href=", map_ready_df$link,">link<a/>"))
}





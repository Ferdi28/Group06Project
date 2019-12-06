#' @title Shiny Application of Indeed Job Map
#' @description Run a shiny app to display Indeed Jobs on a map
#' @import shiny
#' @import tidyverse
#' @import lubridate
#' @import leaflet
#' @export
runDemo <- function() {
  appDir <- system.file("shiny-examples", "indeed_search", package = "group6project")
  if (appDir == "R/RunDemo.R") {
    stop(
      "Could not find example directory. Try re-installing ptds2019hw4g06.",
      call. = FALSE
    )
  }

  shiny::runApp(appDir, display.mode = "normal")

}

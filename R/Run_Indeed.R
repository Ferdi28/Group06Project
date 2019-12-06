#' @title Shiny Application of Indeed Job Map
#' @description Run a shiny app to display Indeed Jobs on a map
#' @import shiny
#' @import tidyverse
#' @import lubridate
#' @import leaflet
#' @export
run_Indeed <- function() {
  appDir <- system.file("shiny-examples", "indeed_search", package = "Group06Project")
  if (appDir == "Run_Indeed/.R") {
    stop(
      "Could not find example directory. Try re-installing ptds2019hw4g06.",
      call. = FALSE
    )
  }

  shiny::runApp(appDir, display.mode = "normal")

}

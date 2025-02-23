% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Map_plot_function.R
\name{map_ready_df}
\alias{map_ready_df}
\title{Indeed data frame}
\usage{
map_ready_df(final_indeed_data, cities_coord)
}
\arguments{
\item{final_indeed_data}{A {Data Frame} scraped using the indeed_scraping function}

\item{cities_coord}{A {Data Frame} with swiss cities names and respective Latitude/Longitude, also provided with this package}
}
\value{

}
\description{
Create a data frame with indeed jobs and their corresponding latitude longitude based on the city
\cr Please make sure you use the following code in order to have the data for the appropriate job category:\cr
- final_indeed_data <- readRDS(file = here :: here("final_indeed_data.rds")) where the Data Frame comes from
the (prepared Data) folder
}
\examples{
map_ready_df(indeed_data)
}

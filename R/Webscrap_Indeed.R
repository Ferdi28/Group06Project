# Run to update the dataframe containing the information about the jobs listed at Indeed.
# Select categories to scrap all the available pages with job listings for these categories.
# Include more or less categories depending on computing power of your computer (Four categories takes about 45 minutes)

library(robotstxt)
library(xml2)
library(rvest)
library(urltools)
library(stringr)

category <- c("data", "finance", "business", "marketing", "insurance", "economics",
              "analyst", "accounting", "consulting", "entrepreneur", "HR", "management",
              "communication", "government")

page_result_start <- 0
page_result_end <- 990
page_results <- seq(from = page_result_start, to = page_result_end, by = 10)
page_results <- seq(from = 0, to = page_result_end, by = 10)
indices = seq(from=0, to=16*length(page_results), by=16)

url <- "https://www.indeed.ch/jobs?q="
url <- c(paste(url, category, sep=""))
url <- c(paste(url, "&l=Switzerland&start=", sep=""))

# Preparing the vectors
job_title <- vector("character", length = 16 * length(page_results))
companies <- vector("character", length = 16 * length(page_results))
locations <- vector("character", length = 16 * length(page_results))
link <- vector("character", length = 16 * length(page_results))
job_description <- vector("character", length = 16 * length(page_results))

job_titles <- matrix("character", nrow = length(page_results)*16, ncol = length(category))
company <- matrix("character", nrow = length(page_results)*16, ncol = length(category))
location <- matrix("character", nrow = length(page_results)*16, ncol = length(category))
links <- matrix("character", nrow = length(page_results)*16, ncol = length(category))

for (y in seq_along(url)){

  for(i in seq_along(page_results)) {

    url2 <- param_set(url[y], key = "start", value = page_results[i])
    page <- xml2::read_html(url2)
    Sys.sleep(2)

    # Scrap the job title
    jobs <- page %>%
      rvest::html_nodes("div") %>%
      rvest::html_nodes(xpath = '//a[@data-tn-element = "jobTitle"]') %>%
      rvest::html_attr("title")

    job_title[indices[i]:(indices[i+1]-1)] <- jobs

    # Scrap the company names
    comp <- page %>%
      html_nodes(".company") %>%
      html_text()

    companies[indices[i]:(indices[i+1]-1)] <- comp

    # Scrap the location
    loc <- page %>%
      html_nodes(".accessible-contrast-color-location") %>%
      html_text()

    locations[indices[i]:(indices[i+1]-1)] <- loc

    # Scrap the links
    lin <- page %>%
      rvest::html_nodes("div") %>%
      rvest::html_nodes(xpath = '//*[@data-tn-element="jobTitle"]') %>%
      rvest::html_attr("href")

    link[indices[i]:(indices[i+1]-1)] <- lin
  }
  job_titles[ ,y] <- job_title
  company[ ,y] <- companies
  location[ ,y] <- locations
  links[ ,y] <- link
}

# Preparing job_titles
colnames(job_titles) <- category
job_titles <- job_titles[1:(nrow(job_titles) - 1), ]
job_titles_vector <- unlist(as.list(job_titles), use.names = FALSE)

# Preparing company
colnames(company) <- category
company <- company[1:(nrow(company) - 1), ]
company <- gsub("\n\n", "", company)
company <- gsub("\n", "", company)

company_vector <- unlist(as.list(company))

# Preparing location
colnames(location) <- category
location <- location[1:(nrow(location) - 1), ]
location_vector <- unlist(as.list(location), use.names = FALSE)
city <- sapply(strsplit(as.character(location_vector),', '), "[", 1)
canton <- sapply(strsplit(as.character(location_vector),', '), "[", 2)

# Preparing categories
categories <- matrix("character", nrow = nrow(job_titles), ncol = ncol(job_titles))
for (i in 1:length(category)){
  categories[ , i] <- category[i]
}

category_vector <- unlist(as.list(categories), use.names = FALSE)

# Preparing link
links <- links[1:nrow(links)-1, ]
link_vector <- unlist(as.factor(links))
link_vector <- paste("https://www.indeed.ch",link_vector, sep="")

# Scrap Job description summary
job_description <- vector("character", length = length(link_vector))

for(i in seq_along(link_vector)) {

  page <- read_html(link_vector[i])
    html_nodes("#jobDescriptionText") %>%
    html_text()
}
job_description <- as.character(job_description)

# Scrap Job_type and Salary
information <- vector("character", length = length(link_vector))
for(i in seq_along(link_vector)) {
  page <- read_html(link_vector[i])
  information[[i]] <- page %>%
    html_nodes(".icl-u-xs-mb--md") %>%
    html_text()
}

salary <- str_split(information, "CHF", simplify = TRUE)[,2:3]
salary <- paste(salary[,1],salary[,2])

info <- str_split(information, "CHF", simplify = TRUE)[,1]
info <- word(info,-1)
job_type <- str_remove_all(info,"[[:upper:]]{2}")
job_type <- str_remove_all(job_type,"Schweiz")    ### Add more languages if necessary
job_type <- str_remove_all(job_type, "Aargau")    ### Add more cities if necessary
job_type <- str_remove_all(job_type, "Bern")

dataset <- data.frame(job_title = job_titles_vector,
                      company = company_vector,
                      city = city,
                      canton = canton,
                      category = category_vector,
                      salary = salary,
                      job_type = job_type,
                      job_description = job_description,
                      link = link_vector)

saveRDS(object = dataset, file = "dataframe.rds")


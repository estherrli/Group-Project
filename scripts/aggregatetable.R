# group by year

library(tidyverse)
netflix_titles <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/netflix_titles.csv")

by_year <- netflix_titles %>%
  mutate(type_media = if_else(type == "Movie", 1, 0)) %>%
  group_by(release_year) %>%
  summarise(
    number_released_in_year = n(),
    num_movies = sum(type_media),
    num_tvshows = number_released_in_year - num_movies,
    movie_tvshow_difference = num_movies - num_tvshows
  )
  names(by_year) [1] <- "Release Year" 
  names(by_year) [2] <- "Total Number of Netflix Entries In Year"
  names(by_year) [3] <- "Number of Movies"
  names(by_year) [4] <- "Number of TV Shows"
  names(by_year) [5] <- "Difference Between Number of Movies and TV Shows"
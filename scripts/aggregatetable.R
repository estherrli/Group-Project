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

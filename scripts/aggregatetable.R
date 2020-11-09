#The second file you should save in your scripts/ directory should create a table of aggregate information about it. 
#It must perform a groupby operation to show a dimension of the dataset as grouped by a particular feature (column). 
#We expect the included table to:
#- Have well formatted (i.e., human readable) column names (so you'll probably have to change them)
# Only contain relevant information (i.e., only select some columns of interest)
# Be intentionally sorted in a meaningful way
# Round any quantitative values so they are displayed in a manner that isn't distracting
# When you display the table in your index.Rmd file, you must also describe why you included the table, 
#and what information it reveals.

#group by year

library(tidyverse)
library(stringr)

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


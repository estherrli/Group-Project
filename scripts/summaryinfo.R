# Most recent or oldest movie added to Netflix
# Average duration of movie
# Year with most movies released
# Most popular country
# Most common type of movie
# Ratings

library(tidyverse)
library(stringr)
netflix_titles <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/netflix_titles.csv")

# Convert movies in duration column to integers
netflix_titles <- netflix_titles %>%
  mutate(duration_nums = sub(" min", "", netflix_titles$duration))
netflix_titles$duration_nums = strtoi(netflix_titles$duration_nums)

summaryinfo <- list()

summaryinfo$most_recent_added_to_netflix <- netflix_titles %>%
  filter(as.Date(date_added, "%B %d, %Y") 
  == max(as.Date(date_added, "%B %d, %Y"), na.rm = TRUE)) %>% 
  pull(title) 

summaryinfo$average_duration_movies <- netflix_titles %>%
  filter(type == "Movie") %>% 
  summarise(avg_duration = mean(duration_nums, na.rm = TRUE)) %>% 
  pull(avg_duration)

summaryinfo$year_most_released_titles <- netflix_titles %>% 
  group_by(release_year) %>% 
  summarise(number = n()) %>% 
  filter(number == max(number)) %>% 
  pull(release_year)

summaryinfo$most_common_tvshow_rating <- netflix_titles %>% 
  filter(type == "TV Show") %>% 
  group_by(rating) %>% 
  summarise(number = n()) %>% 
  filter(number == max(number)) %>% 
  pull(rating)

summaryinfo$num_listed_under_Dramas <- length(netflix_titles[str_detect(
  netflix_titles$listed_in, "Dramas"), "title"])

summaryinfo$num_listed_under_Documentaries <- length(netflix_titles[str_detect(
  netflix_titles$listed_in, "Documentaries"), "title"])
  


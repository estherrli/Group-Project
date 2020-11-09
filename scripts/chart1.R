# Esther: Histogram by year

library(ggplot2)
library(RColorBrewer)
netflix_titles <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/netflix_titles.csv")

each_year <- netflix_titles %>%
  mutate(type_media = if_else(type == "Movie", 1, 0)) %>%
  group_by(release_year) %>%
  summarise(
    number_released_in_year = n(),
    num_movies = sum(type_media),
    num_tvshows = number_released_in_year - num_movies,
    movie_tvshow_difference = num_movies - num_tvshows
  ) %>%
  select(release_year, num_movies, num_tvshows) %>%
  gather(key = type_media, value = number_released_in_year,
         -release_year)

ggplot(data = each_year) +
  geom_col(
    mapping = aes(x = release_year, y = number_released_in_year,
                  fill = type_media),
    )
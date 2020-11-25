# Megan: Scatter plot comparing year vs duration

library(ggplot2)
library(tidyverse)
netflix_titles <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/netflix_titles.csv")

# Convert movies in duration column to integers
netflix_titles <- netflix_titles %>%
  mutate(duration_nums = sub(" min", "", netflix_titles$duration))
netflix_titles$duration_nums = strtoi(netflix_titles$duration_nums)

movie_lengths <- netflix_titles %>% 
  filter(type == "Movie") %>% 
  select(release_year, duration_nums)


ggplot(data = movie_lengths) +
  geom_point(mapping = aes(x = release_year, y = duration_nums), 
             alpha = 0.3) +
  labs(x= "Movie Release Year", y = "Movie Duration (minutes)",
       title = "Netflix Movie Duration vs. Release Year")
77
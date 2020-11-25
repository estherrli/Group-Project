# Cynthia: Bar Chart Movies vs TV Shows
netflix_titles <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/netflix_titles.csv")

# Code for chart
install.packages("ggplot2")
install.packages("RColorBrewer")
library(ggplot2)
library(RColorBrewer)

ggplot(netflix_titles, aes(x = factor(type))) +
  geom_bar(width = 0.5, fill = "skyblue1") +
  geom_text(aes(label = ..count..), stat = "count", vjust = 1.5, colour = "white")


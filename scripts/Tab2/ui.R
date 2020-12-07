library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(stringr)

data_tab2 <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/MoviesOnStreamingPlatforms_updated.csv")


tab2_columns <- data_tab2 %>% 
    filter(Year == max(Year)) %>% 
    separate(Genres, c("Genre", "Genre2", "Genre3"), sep = ",") %>% 
    select(Age, Runtime, Genre, IMDb, Rotten.Tomatoes) 

tab2_select_values <- colnames(tab2_columns)


graph_page <- tabPanel(
    "Tab 2",
    titlePanel("Options"),
    sidebarLayout(
        sidebarPanel(
            x_input <- selectInput(
                "x_var",
                label = "X Variable",
                choices = list(
                    tab2_select_values[1],
                    tab2_select_values[2], 
                    tab2_select_values[3] 
                )
            ),
            y_input <- selectInput(
                "y_var",
                label = "Y Variable",
                choices = list(
                    tab2_select_values[4],
                    tab2_select_values[5]
                )
            ),
            color_input <- selectInput(
                "color",
                label = "Color",
                choices =  list("Red" = "tomato1",
                                "Blue"= "royalblue2",
                                "Green" = "seagreen4",
                                "Purple" = "mediumpurple1")
            )
        ),
        mainPanel(
            ui <- fluidPage(
                h1("Comparing Ratings to Specific Variables"),
                plotlyOutput("scatter", height = "700px"),
                p("While many of the chart options did not seem to have clear
                  correlations, some scatterplots showed to have some
                  sort of pattern to them. In terms of Age rating for 
                  the movies, they seemed to have no clear pattern
                  between IMDb or Rotten Tomato ratings."),
                p("Runtime, however showed to have a higher concentration of
                  ratings (both IMDb and Rotten Tomatoes) between
                  ~60 to ~150 minutes."),
                p("For Genre, highest and
                  most amount of ratings were concentrated in
                  the genres of action, comedy, drama, and 
                  documentarys for Rotten Tomatoes, and for
                  IMDb ratings, these genres were comedy, 
                  documentaries, and Drama")
            )
        )
    )
)



ui <- navbarPage(
    "Movie Exploration",
    graph_page
)

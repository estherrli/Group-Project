library(shiny)
library(shinythemes)
library(ggplot2)
library(tidyverse)
library(plotly)
library(stringr)

## INTRO PAGE ##
intro_page <- tabPanel(
    "Introduction",
    h1("Introduction"),
    p("intro lol")
)


## PAGE 1 ##

# Download datafiles
netflix_titles <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/netflix_titles.csv")
netflix_titles <- netflix_titles %>% 
  separate(listed_in, c("genre", "genre2", "genre3"), sep = ",") %>% 
  mutate(year_added = str_sub(netflix_titles$date_added, start = -4))

# Get vector of movie genres to use for widget
movie_genres <- netflix_titles %>% 
    filter(type == "Movie") %>% 
    pull(genre) %>% 
    unique()

chart1_genre <- selectInput(
    "chart1_genre",
    label = h4("Select a movie genre to display: "),
    choices = movie_genres)


chart1_color <- radioButtons(
    "chart1_color",
    label = h4("Select a bar color: "),
    choices = list("Red" = "tomato1", 
                   "Blue"= "royalblue2", 
                   "Green" = "seagreen4", 
                   "Purple" = "mediumpurple1")
)

page_one <- tabPanel(
    "Netflix Movie Genres",
    h1("Netflix Movie Genre Exploration"),
    sidebarLayout(
        sidebarPanel(p(chart1_genre), p(chart1_color)),
        mainPanel(p(plotlyOutput("chart1", height = "700px")))
    ),
    p("This interactive bar chart displays the number of movies added to Netflix
    each year for a chosen genre. The chosen genre can be altered using the
    first widget. The second widget allows users to change the color of the
    bars. Using this chart, we can explore the total counts of each movie
    genre each year -- for example, we can see that the most Children & 
    Family movies were added in 2019, while the most Stand-Up Comedies were
    added in 2018.")
)


## PAGE 2 ##

data_tab2 <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/MoviesOnStreamingPlatforms_updated.csv")

tab2_columns <- data_tab2 %>% 
    filter(Year == max(Year)) %>% 
    separate(Genres, c("Genre", "Genre2", "Genre3"), sep = ",") %>% 
    select(Age, Runtime, Genre, IMDb, Rotten.Tomatoes, Title) 

tab2_columns$Rotten.Tomatoes <- gsub( "%", "", as.character(tab2_columns$Rotten.Tomatoes))

tab2_columns$Rotten.Tomatoes <- as.numeric(tab2_columns$Rotten.Tomatoes)


tab2_select_values <- colnames(tab2_columns)


page_two <- tabPanel(
    "Movie Ratings",
    h1("Comparing Ratings to Specific Variables in 2020"),
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
                label = "Rating Type",
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
                plotlyOutput("chart2", height = "700px"),
                p("This scatterplot graphs different variables, 
                  including Age, Runtime, and Genre, against
                  different ratings (either IMDb or Rotten Tomatoes)
                  for movies that were released in the year 2020."),
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
                  documentaries for Rotten Tomatoes, and for
                  IMDb ratings, these genres were comedy, 
                  documentaries, and Drama")
            )
        )
    )
)

## PAGE 3 ##

netflix_stock <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/NFLX.csv")


# Get a vector of column names select inputs
y_options <- colnames(netflix_stock)[2:7]

# Layout for visual page tab that has Y variable and color options
page_three <- tabPanel(
    "Netflix Stock Prices",
    h1("Netflix Stock Prices Visualization"),
    sidebarLayout(
        sidebarPanel(
            p("Price Options"),
            selectInput(
                inputId = "chart3_y_var",
                label = "Y Variable",
                choices = y_options
            ),
            selectInput(
                "chart3_color",
                label = "Color",
                choices =  list("Red" = "tomato1",
                                "Blue"= "royalblue2",
                                "Green" = "seagreen4",
                                "Purple" = "mediumpurple1")
            )
        ),
        mainPanel(
            plotlyOutput(outputId = "chart3", height = "700px"),
        )
    ),
    p("This scatter plot graphs the different prices of Netflix stock
              by year. Because each data is organized by year, we can also
              visually see not only how stock prices compared from year to 
              year, but also from day to day and the range of prices in a 
              give year. We were interested in the stock prices of Netflix
              because we beleive stock prices are a good indication of the
              company's overall popularity and growth; thereby suggesting
              trends in overall media usage.")
)

## SUMMARY PAGE ##
summary_page <- tabPanel(
    "Summary",
    mainPanel(
        h1("Summary"),
        tags$strong("Movie Count Per Genre vs. Year Insights"),
        p("Our movie count vs. year bar plot allowed us to see the total number 
          of movies in each genre added to Netflix each year. A notable trend we
          can see in the chart is that between 2016-2017, for many genres,
          there is a steep increase in the number of movies added to Netflix.
          Through this trend, we may be able to infer that these genres became
          more popular during this time period, as Netflix created more contracts
          to add these types of movies to their streaming platform. Furthermore,
          we can see that most of the genres have a steadily increasing count
          as the year increases, which allows us to conclude that Netflix is 
          steadily growing its collection of movies and genres."),
        tags$strong("Stock Price vs. Year Insights"),
        p("Our year vs. stock price scatter plot revealed a variety of
          interesting trends. Firstly, Open, High, Low, and Close stock
          prices reamined under 5 until 2010. After 2010, we see a nearly
          exponential increase in stock prices through 2020, hitting 549
          at its peak. This indicates that Netflix has been growing
          exponentially and furthermore indicates and exponential increase
          in Netflix use and consumption. When looking at trends in the volume
          of Netflix stocks being traded, there is no clear trend (with two
          peaks in 2004 and 2011. Overall, this graph collectively indicates
          that Netflix stock's value is increasing exponentially, which
          may further indicate and exponential increase in media consumption."),
        tags$strong("Movie Ratings Vs Different Variables"),
        p("Our movie ratings Vs dIfferent variables scatterplot
          allowed us to compare and contrast different variables
          and their affect on IMDb and Rotten Tomatoes ratings.
          While not many correlations were obvious in the charts,
          many pattterns emerged. First, we saw that age groups of
          movies did not impact ratings as much as the other variables,
          as many movies were not categorized as a specific age group,
          therefore the chart has less datapoints to create any pattern.
          However, it was clear that the most concentrated amount of
          ratings in the runtimes of ~60 to ~150 minutes, and the higher
          ratings in both IMDb and Rotten Tomatoes were mainly concentrated
          in runtimes of ~85 minutes to ~100 minutes. This may infer that
          movies that are too long or too short tend to have rushed or 
          too slow of a plot. It may also mean that movies within this
          timeframe (80 to 100 minutes) may be the best for all audiences
          to enjoy. Lastly, the genre variable, the highest number of
          ratings for both IMDb and Rotten Tomatoes were concentrated in 
          Comedy, Documentaries, and Drama. Highest ratings were also
          mainly in these categories. This may infer a couple of things, 
          that directors of these specific genres are typically more 
          skilled at keeping audiences engaged and therefore result
          in higher ratings, or that audiences tend to watch more of
          these genres and enjoy them more, regardless of technicalities
          evident in the movie. Overall, some variables are 
          shown to influence the number and the quality of ratings of
          movies more than others.
          ")
        
    )
)

ui <- navbarPage(
    "Netflix Exploration",
    theme = shinytheme("united"),
    intro_page,
    page_one,
    page_two,
    page_three,
    summary_page
)
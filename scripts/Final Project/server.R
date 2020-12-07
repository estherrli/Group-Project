library(shiny)
library(shinythemes)
library(ggplot2)
library(tidyverse)
library(plotly)
library(stringr)

#chart 1 data
netflix_titles <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/netflix_titles.csv")
netflix_titles <- netflix_titles %>% 
    separate(listed_in, c("genre", "genre2", "genre3"), sep = ",") %>% 
    mutate(year_added = str_sub(netflix_titles$date_added, start = -4))
movie_genres <- netflix_titles %>% 
    filter(type == "Movie") %>% 
    pull(genre) %>% 
    unique()

#chart 2 data
data_tab2 <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/MoviesOnStreamingPlatforms_updated.csv")

tab2_columns <- data_tab2 %>% 
    filter(Year == max(Year)) %>% 
    separate(Genres, c("Genre", "Genre2", "Genre3"), sep = ",") %>% 
    select(Age, Runtime, Genre, IMDb, Rotten.Tomatoes, Title) 

tab2_select_values <- colnames(tab2_columns)

#chart 3 data
netflix_stock <- read.csv("https://raw.githubusercontent.com/estherrli/Group-Project/main/data/NFLX.csv")
y_options <- colnames(netflix_stock)[2:7]


server <- function(input, output) {
    # Page 1 chart
    output$chart1 <- renderPlotly({
        # Download datafiles
        filtered_data <- netflix_titles %>% 
            filter(type == "Movie") %>% 
            filter(genre == input$chart1_genre) %>% 
            group_by(year_added, na.rm = T) %>% 
            summarize(count = n(), na.rm = T)
        title <- paste0(
            input$chart1_genre, " Added to Netflix By Year"
        )
        plot <- ggplot(data = filtered_data) + 
            geom_col(mapping = aes(
                x = year_added,
                y = count),
                fill = input$chart1_color)+
            labs(
                x = "Year",
                y = "Number of Movies Added",
                title = title
            )
        ggplotly(plot, tooltip = "y")
    })
    # Page 2 Chart
    output$chart2 <- renderPlotly({
        title <- paste0(input$y_var, " Rating ", " v.s. ", input$x_var)
        p <- ggplot(tab2_columns, aes_string(x = input$x_var, y = input$y_var,
                                             Title = "Title")) +
            geom_point(stat = 'identity', color = input$color) +
            labs(x = input$x_var, y = input$y_var, title = title)+
            theme(axis.text.x=element_text(angle =- 90, vjust = 0.5))
        ggplotly(p, tooltip = c("x", "y", "Title"))
    })
    # Page 3 Chart
    output$chart3 <- renderPlotly({
        
        # Store the title of the graph in a variable indicating the x/y variables
        title <- paste0("Netflix Stock Prices: ",
                        "Year vs ", input$chart3_y_var)
        
        # separate date into three columns (year, month, day) calculate average
        # for each variable by year
        stock_plot <- netflix_stock %>%
            mutate(year = lubridate::year(Date), 
                   month = lubridate::month(Date), 
                   day = lubridate::day(Date))
        
        # Create ggplot scatter
        p <- ggplot(stock_plot) +
            geom_point(mapping = aes_string(x = "year", y = input$chart3_y_var),
                       color = input$chart3_color) +
            labs(x = "Year", y = input$chart3_y_var, title = title)
        p
    })
    
}







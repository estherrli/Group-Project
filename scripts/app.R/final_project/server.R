
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(stringr)
library(plotly)
library(stringr)

netflix_stock <- read.csv("NFLX.csv")


server <- function(input, output) {
    output$scatter <- renderPlotly({
        
        # Store the title of the graph in a variable indicating the x/y variables
        title <- paste0("Netflix Stock Prices: ",
                        "Year vs ", input$y_var)
        
        # separate date into three columns (year, month, day) calculate average
        # for each variable by year
       stock_plot <- netflix_stock %>%
            mutate(year = lubridate::year(Date), 
                    month = lubridate::month(Date), 
                    day = lubridate::day(Date))
       
            
        
        # Create ggplot scatter
        p <- ggplot(stock_plot) +
            geom_point(mapping = aes_string(x = "year", y = input$y_var),
                       color = input$color) +
            labs(x = "Year", y = input$y_var, title = title)
        p
    })
}
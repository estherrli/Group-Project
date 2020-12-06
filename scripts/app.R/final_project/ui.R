library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(stringr)
library(plotly)
library(stringr)


netflix_stock <- read.csv("NFLX.csv")

# Get a vector of column names select inputs
y_options <- colnames(netflix_stock)

#introduction page
intro_page <- tabPanel(
    "Introduction",
    mainPanel(
        h2("Topic Introduction"),
        p("paragraph")
    )
)

# Layout for visual page tab that has Y variable and color options
visual_page <- tabPanel(
    "Visualization Page",
    sidebarLayout(
        sidebarPanel(
            p("Price Options"),
            selectInput(
                inputId = "y_var",
                label = h3("Y Variable"),
                choices = y_options
            ),
            selectInput(
                inputId = "color",
                label = h3("Color"),
                choices = list("Red" = "red", "Blue" = "blue", "Green" = "green")
            )
            
        ),
        mainPanel(
            h2("Netflix Stock Prices Visualization"),
            plotlyOutput(outputId = "scatter"),
            p("This scatter plot graphs the different prices of Netflix stock
              by year. Because each data is organized by year, we can also
              visually see not only how stock prices comapred from year to 
              year, but also from day to day and the range of prices in a 
              give year. We were interested in the stock prices of Netflix
              because we beleive stock prices are a good indication of the
              company's overall popularity and growth; thereby suggesting
              trends in overall media usage.")
        )
    )
)





#`y_input` that stores a `selectInput()` for your variable to appear on the y
#axis of your chart.

y_input <- selectInput(
    "y_var",
    label = "Y Variable",
    choices = y_options
)

# variable `color_input` as a `selectInput()` that allows users to
# select a color from a list of choices

color_input <- selectInput(
    "color",
    label = "Color",
    choices = list("Red" = "red", "Blue" = "blue", "Green" = "green")
)

# UI page
ui <- navbarPage(
    "Climate Change", 
    intro_page,
    visual_page
)

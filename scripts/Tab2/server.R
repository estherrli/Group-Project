library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(stringr)


server <- function(input, output) {
    output$scatter <- renderPlotly({
        title <- paste0(input$y_var, " Rating ", " v.s. ", input$x_var)
        p <- ggplot(tab2_columns, aes_string(x = input$x_var, y = input$y_var)) +
            geom_point(stat = 'identity', color = input$color) +
            labs(x = input$x_var, y = input$y_var, title = title)+
            theme(axis.text.x=element_text(angle =- 90, vjust = 0.5))
        ggplotly(p)
    })
}







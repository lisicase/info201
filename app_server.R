# Set Up -------------------------------------------------------------

# Load packages and sources
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
source("scripts/funding-sources.R")

# Server -------------------------------------------------------------

# Create server for school funding data
my_server <- function(input, output) {
  output$viz <- renderPlot({
    return(funding_graph(input$years, input$state))
  })
}

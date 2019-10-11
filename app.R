# Set Up -------------------------------------------------------------

# Load packages and sources
library(shiny)
source("app_ui.R")
source("app_server.R")

# Run the App --------------------------------------------------------
shinyApp(ui = my_ui, server = my_server)

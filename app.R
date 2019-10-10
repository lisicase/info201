# Set Up -------------------------------------------------------------

# Load packages and sources
library(shiny)
source("app_ui.R")
source("app_server.R")

# To start running your app, pass the variables defined in previous
# code snippets into the `shinyApp()` function
shinyApp(ui = my_ui, server = my_server)

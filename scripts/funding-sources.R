# Load packages
library("dplyr")
library("ggplot2")
library("stringr")

# Function to create graph of funding
funding_graph <- function(years, state) {
  # Load aggregated data
  funding_data <- read.csv("data/prepped/aggregate.csv",
                           stringsAsFactors = FALSE)
  # Narrow data to specified years for given state and reshape for plotting
  plot_data <- funding_data %>%
    filter(str_to_title(State.Name) == state) %>%
    filter(Year > years[1],
           Year < years[2]) %>%
    mutate("Federal Revenue" = Federal.Revenue,
           "State Revenue" = State.Revenue,
           "Local Revenue" = Local.Revenue) %>%
    select(Year, "Federal Revenue", "State Revenue", "Local Revenue") %>%
    gather("Source", "Funding", 2:4)
  # Create the plot
  ggplot(
    data = plot_data,
    mapping = aes_string(x = "Year", y = "Funding",
                         color = "Source")
  ) +
    geom_smooth(se = FALSE)
}
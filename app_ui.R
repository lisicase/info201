# Set Up -------------------------------------------------------------

# Load packages
library(shiny)
library(ggplot2)
library(dplyr)
library(stringr)

# Page 1 - Introduction ----------------------------------------------

# Create main panel of overview content
overview_content <- mainPanel(
  h4("Major Questions"),
  p("School budgets and how they're funded has become an increasingly important
    concern for many Americans. Accordingly, I would like to be able to answer
    the following questions about education funding in the United States:"),
  p("How has the amount of funding for education from different sources changed
    over the years for a particular state? Is education generally funded by one
    source in particular? What is the most common source of funding? Does that
    differ between states?"),
  h4("The Data"),
  p("To answer these questions, I am using data from the annual \"Local
    Education Agency (School District) Finance Survey\" (Survey F-33). The U.S.
    Census Bureau, under authorization from Title 13, United States Code,
    Sections 161 and 182, surveys every primary and secondary schools in each
    district of the country, including Washington D.C., to collect information
    on education finances. This allows us to learn about salaries, debt,
    student count, funding, expenditures, as well as other monetary figures.
    The survey data can be found ",
    a(
      href = "https://nces.ed.gov/ccd/f33agency.asp",
      strong("here")
    ),
    "."
  ),
  p("My team compiled the available data from ",
    strong("1995 to 2016"),
    " for analysis. Specifically, we decided to look at funding sources,
    salaries, and basic expenditures, and grouped the data by state. Note that",
    em("our data is normalized"),
    " according to the number of students in order to account for varying state
    populations. Accordingly, each unit of money is measured in USD per
    student."
  )
)

# Create side panel of photos
question_panel <- sidebarPanel(
  img(src = "teacherprotest.jpg"),
  p("Thousands of teachers and their supporters rally outside City Hall
    in Los Angeles."),
  img(src = "laborstrikes.jpg"),
  p("This chart of USA workers involved in strikes over the years shows
    how teacher strikes skyrocketed in 2018."),
  p(
    em("Via ",
       a(
         href = paste0("https://beta.washingtonpost.com/us-policy/2019/02/14/",
                       "with-teachers-lead-more-workers-went-strike-than-any-",
                       "year-since/"),
         "The Washington Post"
       )
    )
  )
)

# Create overview page
overview <- tabPanel(
  "Overview",
  titlePanel("Overview"),
  sidebarLayout(
    overview_content,
    question_panel
  )
)

# Page 2 - Vizualization ---------------------------------------------

# Read in aggregate csv
funding_data <- read.csv("data/prepped/aggregate.csv",
                         stringsAsFactors = FALSE)

# Find time range in years
time_range <- range(funding_data$Year)

# Create slider for choosing time range
years_input <- sliderInput(
  inputId = "years",
  label = "Time Range",
  min = time_range[1],
  max = time_range[2],
  value = time_range,
  step = 1
)

# Find state names
state_names <- unique(str_to_title(funding_data[ ,"State.Name"]))

# Create dropdown menu to select feature of interest
feature_input <- selectInput(
  inputId = "state",
  label = "State of Interest",
  choices = state_names,
  selected = "Alabama"
)

# Create the page
interactive_viz <- tabPanel(
  "Funding Over Time",
  titlePanel("Funding Over Time"),
  p(em("Learn about how much revenue a state receives from federal, local, and
       state sources over a period of time.")),
  sidebarLayout(
    sidebarPanel(
      years_input,
      feature_input
    ),
    mainPanel(
      plotOutput("viz")
    )
  )
)

# Page 3 - Summary Takeaways -----------------------------------------

takeaway_content <- mainPanel(
  p("Looking at USA school funding data through visualizations such as the one
    included here can help us observe characteristics and trends for how it's
    changed over time and accross states. I have described some of my own
    takeaways from the included infographic below."),
  p("First, schools tend to get most of their funding from their states,
    although a small number get most of their funding locally."),
  p("Second, federal revenue per student is usually substantially lower than
    state or local. One main outlier to this is New Mexico, where federal
    revenue is about level with local revenue. Interesting as well is that
    Hawaii’s federal funding is greater than local funding, but its state
    funding is much greater than that of other states in the US."),
  p("Finally, funding for education has generally increased over the years.
    It’s worth noting that in 2009, Obama passed the Recovery Act to
    temporarily increase federal funding of schools, and from these graphs,
    it’s clear that this was indeed very temporary. While federal funding has
    tended to increase at a relatively steady rate overall, for many states, it
    has also had a slight decline since around 2010.")
  )

# Create a side panel of outlier plots.
plots_panel <- sidebarPanel(
  img(src = "plot_newmexico.jpg"),
  p("New Mexico Funding"),
  img(src = "plot_hawaii.jpg"),
  p("Hawaii Funding")
)

# Create takeaway page
takeaways <- tabPanel(
  "Takeaways",
  titlePanel("Summary Takeaways"),
  sidebarLayout(
    takeaway_content,
    plots_panel
  )
)

# User Interface -----------------------------------------------------

# Create the multi-page layout
my_ui <- navbarPage(
  "Final Deliverable", overview, interactive_viz, takeaways,
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  )
)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Word Predictor"),
        
        # Sidebar with a slider input for the number of bins
        sidebarLayout(
                sidebarPanel(
                        div("Please wait a few moments for data loading..."),
                        div("Enter your search term below."),
                        textInput("searchTerm", label = h3("Search Term"),
                          value = ""),
                        sliderInput("termNumber", label = h3("Number to Return"),
                                    min = 1, max = 25, value = 5)),
                mainPanel(
                        h4("Ranking by Frequency of Use"),
                        tableOutput("predictedText")
                )
        )
))

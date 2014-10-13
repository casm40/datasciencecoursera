library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Word Predictor"),
        
        # Sidebar with a slider input for the number of bins
        sidebarLayout(
                sidebarPanel(
                        div("Please wait a few moments for data loading..."),
                        radioButtons("radio",
                                label = h3("Choose Dictionary"),
                                choices = list("Bauman"=1,
                                               "Medical"=2,
                                               "Ngram"=3),
                                selected = 3),
                        textInput("searchTerm", label = h3("Search Term"),
                          value = ""),
                        sliderInput("termNumber", label = h3("Number to Return"),
                                    min = 1, max = 25, value = 5)),
                

                # Show a plot of the generated distribution
                mainPanel(
                        h4("Ranking by Frequency of Use"),
                        tableOutput("predictedText")
                )
        )
))

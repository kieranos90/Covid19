#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Covid-19 Cases in England"),

    # Sidebar with a slider input for number of bins
    
    fluidRow(
        column(width = 2,
                checkboxGroupInput("Region",
                                    "Select Regions:",
                                    levels(data$Region),
                                    selected = levels(data$Region)
                                    ),
               radioButtons("Radio", label = "Bar Chart Display",
                            choices = list("Cases" = 1, "Cases per 100,000 People" = 2), 
                            selected = 1)
             ),
        # Show a plot of the generated distribution
        column(width = 10,
                tabsetPanel(type = "tabs",
                            tabPanel("Bar Chart", plotlyOutput("distPlot")),
                            tabPanel("Table", dataTableOutput("Table"))
                             )
            
        )
    )
))

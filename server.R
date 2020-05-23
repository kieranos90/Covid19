#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)
library(DT)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    data <- read.csv("CV Data.csv")
    
    data2 <- select(data, Region, Area, Cases, Cases_per_100000)

    filtered <- reactive({ 
        
        filter(data[data$Region %in% input$Region,])
    })
    
    filtered2 <- reactive({ 
        
        filter(data2[data2$Region %in% input$Region,])
    })
    

    output$distPlot <- renderPlotly({
       
        if(input$Radio == 1){
            p <- ggplot(data = filtered(),
                        aes(x = reorder(Area, Ord), y = Cases,
                            fill = Region,
                            text = paste("Area =", Area,
                                         "<br>Region =", Region,
                                         "<br>Cases =", Cases,
                                         "<br>Cases per 100,000 People =", Cases_per_100000))) +
                geom_bar(stat = "identity", colour = "black") +
                theme_minimal() + 
                theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                xlab("Local Area") + ylab("Cases") + 
                ggtitle("Covid-19 Cases by English Local Area")
        }
        
        else {
            p <- ggplot(data = filtered(),
                        aes(x = reorder(Area, Ord), y = Cases_per_100000,
                            fill = Region,
                            text = paste("Area =", Area,
                                       "<br>Region =", Region,
                                       "<br>Cases =", Cases,
                                       "<br>Cases per 100,000 People =", Cases_per_100000))) +
                geom_bar(stat = "identity", colour = "black") +
                theme_minimal() + 
                theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                xlab("Local Area") + ylab("Cases per 100,000 people") + 
                ggtitle("Covid-19 Cases by English Local Area")
        }
        
        ggplotly(p, tooltip = "text", height = 650)%>%
            layout(hoverlabel = list(bgcolor = "white"))
        })
    
    output$Table <- renderDataTable({
        datatable(data = filtered2(),
                  colnames = c("Region", "Area", "Cases", "Cases per 100,000 people"))
    })

})

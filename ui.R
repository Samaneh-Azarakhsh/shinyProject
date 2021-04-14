library(shiny)
library(ggplot2)
library(ggpubr)
# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("app samaneh"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "variables", label = "Number of Variables",choices = c(3:10)),
            selectInput(inputId = "clustersReal", label = "Number of Clusters to Simulate",choices = c(3:10)),
            selectInput(inputId = "clustersFit", label = "Number of Clusters to Fit",choices = c(3:10)),
            sliderInput(inputId = "clustersSize", label = "Range of Clusters Size",
                         value =  c(70, 150), min = 50, max = 200)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           fluidRow(
               column(width = 12, plotOutput('PlotSimulated'))
           )
            
        )
    )
))

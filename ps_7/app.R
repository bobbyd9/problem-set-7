#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(plotly)
library(rsconnect)
library(shinythemes)
library(scales)

shinydata <- readRDS("master_context.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("House Predicted Error"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("x", "Education or Household Variable:", choices = c(
        `Median Household Income` = "median_hh_inc", 
        `Unemployment Percentage` = "clf_unemploy_pct",
        `Less than High School` = "lesshs_pct",
        `Less than College` = "lesscollege_pct",
        `Less than High School (Whites)` = "lesshs_whites_pct",
        `Less than College (Whites)` = "lesscollege_whites_pct",
        `Rural Population` = "rural_pct"
      ))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("shinydata"),
      br(), br()
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$shinydata <- renderPlot({
    
    
    ggplot(shinydata, aes_string(x = "error", y = input$x, col = "state")) + 
      geom_point()+
      labs(title = "Comparasion of Predicted to Actual Republican Advantages",
           subtitle = "In Percent",
           x = "Error")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
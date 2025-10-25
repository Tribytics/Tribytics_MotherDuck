#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#


library(dplyr)
library(dbplyr)
library(duckdb)
library(shiny)
library(spatial)


conn <- md_connect() 

enc_sample <- tbl(conn, I("my_db.ccdm.encounters_sample"))

ages <- enc_sample |> 
   pull(anchor_age)

dbDisconnect(conn)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("DuckDB/MotherDuck demo"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x <- ages # from global.R
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, 
             breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Age of patient (anchor_age)',
             main = 'Histogram of patient ages')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

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

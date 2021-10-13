library(shiny)
library(tidyverse) 
library(moderndive)
library(bslib)    

quant_vars <- house_prices %>% 
  select(-id, -zipcode, -waterfront, -grade, -condition, where(is.numeric)) %>% 
  names() %>% 
  sort()

ui <- fluidPage(
  theme = bs_theme(primary = "#8f20d4", 
                   secondary = "#8f20d4", 
                   base_font = list(font_google("Fira Sans")), 
                   code_font = list(font_google("Fira Sans")), 
                   heading_font = list(font_google("Fira Sans")),
                   bootswatch = "minty", bg = "#cec1e7", fg = "#FFFFFF"),
  
  titlePanel("What does a distribution of the quantitative variables look like?"),
  
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "var", 
                  label = "Select a variable:", 
                  choices = quant_vars, 
                  selected = ""
      )
    ),
    
    # Show a scatterplot of variable on x with 
    # price on y
    mainPanel(
      plotOutput(outputId = "histogram"),
    )
  )
)


server <- function(input, output) {
  bs_themer()
  

  
  output$histogram <- renderPlot({
      house_prices %>%
          ggplot(aes(x = .data[[input$var]])) +
          geom_histogram(fill = "navy") +
          theme(panel.grid.major = element_blank(), 
                panel.grid.minor = element_blank(),
                panel.background = element_blank(), 
                plot.background = element_rect(fill = "#cec1e7"))
  })
  
}


shinyApp(ui = ui, server = server)

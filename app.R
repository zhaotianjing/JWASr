
library(shiny)

# Define UI ----
ui <- fluidPage(
  titlePanel("JWAS"),
  
  fluidRow(
    ### Part 1. Data
    column(12,
           wellPanel(fileInput("file1", h4("Choose CSV File"),
                     multiple = TRUE,
                     accept = c("text/csv",
                                "text/comma-separated-values,text/plain",
                                ".csv")),
           
                     tags$hr(),
                     checkboxInput("header", "Header", TRUE),
                     radioButtons("sep", "Separator",
                                  choices = c(Comma = ",",
                                              Semicolon = ";",
                                              Tab = "\t"),
                                  selected = ","),
                     radioButtons("quote", "Quote",
                                  choices = c(None = "",
                                              "Double Quote" = '"',
                                              "Single Quote" = "'"),
                                  selected = '"'),
                     tags$hr(),
                     radioButtons("disp", "Display",
                                  choices = c(Head = "head",
                                              All = "all"),
                                  selected = "head")
                     
           
           )
    ),
    
    column(12, wellPanel( h4("View data"),tableOutput("contents"))
           ),
    
    ###part 2. model
    column(12, wellPanel(textInput("model",
                         label = h4("Enter model:"),
                         value ="y = x...")
                          )
          )
    ,

    column(12,wellPanel(textInput("R",
                        label = h4("Enter R:"),
                       value ="1")
                       
                       )
    ),
    
    column(12, wellPanel(h4("Check model"),textOutput("mymodel"))),
    
    ###part 3. result
    column(12, wellPanel( h4("Model Result"),textOutput("model_result"))
          )
    
    
  )
  
)

# Define server logic ----
server <- function(input, output) {
  output$contents <- renderTable({
    
    req(input$file1)
    
    df <- read.csv(input$file1$datapath,
                   header = input$header,
                   sep = input$sep,
                   quote = input$quote)
    
    if(input$disp == "head") {
      return(head(df))
    }
    else {
      return(df)
    }
  
    
    
  })
  
  output$mymodel <- renderText({ 
    paste("Your model is:",
          input$model,"with R = ",input$R)
  })

  
}

# Run the app ----
shinyApp(ui = ui, server = server)




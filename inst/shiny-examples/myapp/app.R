# global set up
cat("begin set up\n")
path_libjulia = "C:/Users/ztjsw/AppData/Local/Julia-0.7.0/bin/libjulia.dll"
JWASr::jwasr_setup_win(path_libjulia)
library("JWASr")
cat("end set up\n")


# Define UI ----
ui <- fluidPage( 
  titlePanel("JWASr"),
  
  fluidRow(
    ### Part 1. Data
    column(12,wellPanel(textInput("data_path", label = h4("Data path"), value = "D:/JWASr/data/phenotypes.txt"))),
    
    ###part 2. model & R
    column(12, wellPanel(textInput("model",label = h4("Enter model:"),value ="y1 = intercept + x1*x3 + x2 + x3"),
                         numericInput("R",label = h4("Enter R:"),value =1.0))),
    
    ###part 3. set covariate & random
    column(12, wellPanel(textInput("cov",label = h4("set covariate"),value ="x1"))),
    
    ### set random
    column(12, wellPanel(textInput("ran",label = h4("set random"),value ="x2"),
                         numericInput("G1",label = h4("Enter G1"),value =1.0))),
    
    
    ###part 4. outputMCMCsamples
    column(12, wellPanel(textInput("outputMCMC",label = h4("output samples"),value ="x3"))),
    
    ###part 5. run
    column(12, wellPanel(numericInput("chain_length",label = h4("chain_length"),value =5000),
                         numericInput("output_samples_frequency",label = h4("output_samples_frequency"),value =100))),
    column(12, wellPanel(actionButton("run",label = h4("run"))))
    

  )
  
)



# Define server logic ----
server <- function(input, output) {

    observeEvent(input$run, {

      data_path = input$data_path
      data = read.csv(data_path,header = T, sep = ",")
      # data = phenotypes
      cat("\nHead of data is:")
      cat("\n")
      print(head(data))
      cat("\n")
 
      equation = input$model
      R = input$R
      model = build_model(equation, R)
      cat("\nModel is:")
      cat("\n")
      print(model)
      cat("\n")

      x_cov_temp = input$cov
      set_covariate(model, x_cov_temp)
      cat(sprintf("\nset covariate: %s\n",x_cov_temp))

      G1 = input$G1
      x_ran_temp = input$ran
      set_random(model, x_ran_temp, G1)
      cat("\nset random: ",x_ran_temp,", with G1:",G1)
      cat("\n")

      x_output_temp = input$outputMCMC
      outputMCMCsamples(model, x_output_temp)
      cat("\noutput MCMC samples:", x_output_temp)
      cat("\n")
      
      chain_length = input$chain_length
      output_samples_frequency = input$output_samples_frequency
      cat("\n")
      cat("chain_length",chain_length)
      cat("\n")
      cat("output_samples_frequency",output_samples_frequency)
      cat("\n")
      cat("\n")
      
      out = runMCMC(model, data, chain_length = chain_length, output_samples_frequency = output_samples_frequency)
      print(out)
    })
    
    
}






# Run the app ----
shinyApp(ui = ui, server = server)




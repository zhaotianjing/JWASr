
# Define UI ----
ui <- fluidPage(
  titlePanel("JWASr"),

  fluidRow(
    ### set up
    column(6,wellPanel(textInput("path_libjulia", label ='For windows user, please enter path for "libjulia.dll":', value = "C:/Users/ztjsw/AppData/Local/Julia-0.7.0/bin/libjulia.dll"),
                        actionButton("win_set_up",label = "Windows user set up"))),
    column(6,wellPanel(actionButton("mac_set_up",label = "Mac/Linux user set up"))),

    ### Part 1. Data
    column(12,wellPanel(fileInput("data_file", label = "Please choose your data file:"),
                        checkboxInput("header", "Header", TRUE),
                        radioButtons("sep","Separator", choices = list("comma" = ",","space" = " ")))),

    ###part 2. model & R
    column(12, wellPanel(textAreaInput("model",label = "Enter model:",value ="y1 = intercept + x1*x3 + x2 + x3"),
                         numericInput("R",label = "Enter R:",value =1.0))),

    ###part 3. set covariate & random
    column(12, wellPanel(textInput("cov",label = "Set covariate",value ="x1"))),

    ### set random
    column(12, wellPanel(textInput("ran",label = "Set random",value ="x2"),
                         numericInput("G1",label = "Enter G1",value =1.0))),


    ###part 4. outputMCMCsamples
    column(12, wellPanel(textInput("outputMCMC",label = "Output samples",value ="x3"))),

    ###part 5. run
    column(12, wellPanel(numericInput("chain_length",label = "Chain length",value =5000),
                         numericInput("output_samples_frequency",label = "Output samples frequency",value =100))),
    column(12, wellPanel(actionButton("run",label = "Run")))


  )

)



# Define server logic ----
server <- function(input, output) {
    # set up for Windows
    observeEvent(input$win_set_up, {
      cat("begin set up\n")
      path_libjulia = input$path_libjulia
      JWASr::jwasr_setup_win(path_libjulia)
      library("JWASr")
      cat("end set up\n")
    })
    # set up for Mac
    observeEvent(input$mac_set_up, {
      cat("begin set up\n")
      JWASr::jwasr_setup()
      library("JWASr")
      cat("end set up\n")
    })

    #
    observeEvent(input$run, {
      data_file = input$data_file
      data = read.csv(data_file$datapath, header = input$header, sep = input$sep)
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




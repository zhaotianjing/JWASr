
# Define UI ----
ui <- fluidPage(
  titlePanel("JWASr"),

  fluidRow(
    ### set up
    column(8,h3("Step 1. Set up"),wellPanel(textInput("path_libjulia", label =HTML("<p>For windows user, please enter path for <em>libjulia.dll</em>:</p>"), value = "C:/Users/ztjsw/AppData/Local/Julia-0.7.0/bin/libjulia.dll"),
                                            HTML("<p><strong>Then click:</strong></p>"),actionButton("win_set_up",label = "Windows user set up"))),
    column(8,wellPanel(HTML("<p><strong>For Mac/Linux user, click:</strong></p>"),actionButton("mac_set_up",label = "Mac/Linux user set up"))),

    ### Part 1. Data
    column(8,h3("Step 2. Read data"),wellPanel(fileInput("data_file", label = HTML("Please choose your <em>data</em> file:")),
                        checkboxInput("header", "Header", TRUE),
                        radioButtons("sep","Separator :", choices = list("comma" = ",","space" = " ")),
                        actionButton("view_data",label = "View head of data"),
                        tableOutput("table"))),
    #pedigree
    column(8,wellPanel(fileInput("ped_file", label = HTML("Please choose your <em>pedigree</em> file:")),
                                 checkboxInput("header_ped", "Header", TRUE),
                                 radioButtons("sep_ped","Separator :", choices = list("comma" = ",","space" = " ")),
                                 actionButton("view_ped",label = "View head of pedigree file"),
                                 tableOutput("table_ped"))),
    ###part 2. model & R
    column(8, h3("Step 3. Build Model"), wellPanel(textAreaInput("model",label = "Enter model equations:",value ="y1 = intercept + x1 + x3 + ID + dam
y2 = intercept + x1 + x2 + x3 + ID
y3 = intercept + x1 + x1*x3 + x2 + ID"),textAreaInput("R_diag",label = HTML("<p>Enter <em>R</em>:</p><p>Note: <em>R</em> is a number/matrix</p>"),value ="1,0,0
0,1,0
0,0,1"))),




    ###part 3. set covariate
    column(8, h3("Step 4. Set Covariate"),wellPanel(textInput("cov",label = "Set covariate",value ="x1"))),

    ### Step 5: Set Random
    column(8, h3("Step 5. Set Random Effects"),wellPanel(textInput("ran",label = "Set random",value ="x2"),
                         textAreaInput("G1",label = HTML("<p>Enter <em>G1</em>:</p><p>Note: <em>G1</em> is a number/matrix</p>"),value ="1,0
0,1"))),

    #random w/ ped
    column(8,wellPanel(textInput("ran_ped",label = HTML("Set random with <em>pedigree</em>"),value ="ID dam"),
                                                         textAreaInput("G2",label = HTML("<p>Enter <em>G2</em>:</p><p>Note: <em>G2</em> is a number/matrix</p>"),value ="1,0,0,0
0,1,0,0
0,0,1,0
0,0,0,1"))),

    ###geno
    column(8,h3("Step 6. Use Genomic Information"),wellPanel(textAreaInput("G3",label = HTML("<p>Enter <em>G3</em>:</p><p>Note: <em>G3</em> is a number/matrix</p>"),value ="1,0,0
0,1,0
0,0,1"),
      fileInput("geno_file", label = HTML("Please choose your <em>genotypes</em> file:")),
                       checkboxInput("header_geno", "Header", TRUE),
                       radioButtons("sep_geno","Separator :", choices = list("comma" = ",","space" = " ")),
                       actionButton("view_geno",label = "View head of genotypes file"),
                       tableOutput("table_geno"))),


    ###part 4. outputMCMCsamples
    column(8, h3("Step 7. Run Analysis"),wellPanel(textInput("outputMCMC",label = "Output samples",value ="x2"))),

    ###part 5. run
    column(8, wellPanel(textInput("methods",label = "Method",value ="conventional (no markers)"),
                        numericInput("chain_length",label = "Chain length",value =5000),
                         numericInput("output_samples_frequency",label = "Output samples frequency",value =100),
                        checkboxInput("outputebv", "outputEBV", FALSE),
                        checkboxInput("estimatepi", "estimatePi", FALSE))),
    column(8, wellPanel(actionButton("run",label = "Run")))


  )

)



# Define server logic ----
server <- function(input, output) {
    # set up for Windows
    observeEvent(input$win_set_up, {
      cat("Begin set up\n")
      path_libjulia = input$path_libjulia
      JWASr::jwasr_setup_win(path_libjulia)
      library("JWASr")
      cat("End set up!!!\n")
    })
    # set up for Mac
    observeEvent(input$mac_set_up, {
      cat("Begin set up\n")
      JWASr::jwasr_setup()
      library("JWASr")
      cat("End set up!!!\n")
    })
    #view data
    observeEvent(input$view_data, {
      data_file = input$data_file
      data = read.csv(data_file$datapath, header = input$header, sep = input$sep)
      head = head(data)
      output$table <- renderTable(head)
    })

    #view pedigree
    observeEvent(input$view_ped, {
      ped_file = input$ped_file
      ped = read.csv(ped_file$datapath, header = input$header_ped, sep = input$sep_ped)
      head_ped = head(ped)
      output$table_ped <- renderTable(head_ped)
    })

    #view geno
    observeEvent(input$view_geno, {
      geno_file = input$geno_file
      geno = read.csv(geno_file$datapath, header = input$header_geno, sep = input$sep_geno)
      head_geno = head(geno)
      output$table_geno <- renderTable(head_geno)
    })

    ###########
    observeEvent(input$run, {
      #read data
      data_file = input$data_file
      data = read.csv(data_file$datapath, header = input$header, sep = input$sep)

      #read pedigree
      ped_file = input$ped_file
      ped_path = ped_file$datapath
      pedigree = get_pedigree(ped_path, separator=input$sep_ped, header=input$header_ped)


      equation = input$model

      R_diag_str = input$R_diag
      R_diag = as.matrix(read.table(text = R_diag_str, sep = ","))



      model = build_model(equation, R_diag)


      x_cov_temp = input$cov
      set_covariate(model, x_cov_temp)

      #random
      G1_diag_str = input$G1
      G1 = as.matrix(read.table(text = G1_diag_str, sep = ","))


      x_ran_temp = input$ran
      set_random(model, x_ran_temp, G1)


      #random w/ ped
      G2_diag_str = input$G2
      G2 = as.matrix(read.table(text = G2_diag_str, sep = ","))


      x_ran_ped_temp = input$ran_ped
      set_random_ped(model, x_ran_ped_temp, pedigree, G2)




      #read geno
      G3_diag_str = input$G3
      G3 = as.matrix(read.table(text = G3_diag_str, sep = ","))

      geno_file = input$geno_file
      geno_path = geno_file$datapath
      add_genotypes(model, geno_path, G3, separator=input$sep_geno, header = input$header_geno)



      x_output_temp = input$outputMCMC
      outputMCMCsamples(model, x_output_temp)


      chain_length = input$chain_length
      output_samples_frequency = input$output_samples_frequency

      outputebv=input$outputebv
      methods = input$methods
      estimatePi=input$estimatepi


      out = runMCMC(model, data, methods = methods,estimatePi=estimatePi,chain_length=chain_length,output_samples_frequency=output_samples_frequency,outputEBV=outputebv)
      print(out)
    })


}






# Run the app ----
shinyApp(ui = ui, server = server)




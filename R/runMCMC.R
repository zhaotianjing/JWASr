#' @export

runMCMC = function(model, data,
                  #chain
                  chain_length                    = 100,
                  starting_value                  = FALSE,
                  burnin                          = 0,
                  # output_samples_file             = "MCMC_samples",
                  output_samples_frequency        = 0,
                  printout_model_info             = TRUE,
                  printout_frequency              = chain_length+1,
                  #methods
                  methods                  = "conventional (no markers)", 
                  Pi = 0.0, 
                  estimatePi = FALSE,
                  missing_phenotypes       =TRUE, 
                  constraint = FALSE,
                  estimate_variance        =TRUE,
                  update_priors_frequency  =0,
                  #parameters for single-step analysis
                  single_step_analysis     = FALSE,
                  pedigree                 = FALSE,
                  #output
                  outputEBV                =TRUE,
                  output_heritability      = FALSE #complete or incomplete genomic data
                  # output_PEV               = FALSE
                  )
{
  output_samples_frequency = as.integer(output_samples_frequency)
  update_priors_frequency = as.integer(update_priors_frequency)


  JuliaCall::julia_call("runMCMC", model, data, chain_length=chain_length, 
    starting_value=starting_value, 
    burnin=burnin, 
    # output_samples_file=output_samples_file, 
    output_samples_frequency=output_samples_frequency,
    printout_model_info=printout_model_info, 
    printout_frequency=printout_frequency, 
    methods = methods,
    Pi= Pi,
    estimatePi=estimatePi, 
    missing_phenotypes=missing_phenotypes, 
    constraint=constraint, 
    estimate_variance=estimate_variance, 
    update_priors_frequency=update_priors_frequency, 
    single_step_analysis=single_step_analysis,
    pedigree=pedigree,
    outputEBV=outputEBV,
    output_heritability=output_heritability
    # output_PEV=output_PEV
    )
}

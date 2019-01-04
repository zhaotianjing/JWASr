#' @export

runMCMC = function(model, data, estimatePi = FALSE, chain_length = 100, methods="conventional (no markers)", output_samples_frequency = 0, outputEBV = FALSE
                  #chain
                  chain_length                    = 100,
                  starting_value                  = false,
                  burnin                          = 0,
                  output_samples_file             = "MCMC_samples",
                  output_samples_frequency::Int64 = 0,
                  printout_model_info             = true,
                  printout_frequency              = chain_length+1,
                  #methods
                  methods                  = "conventional (no markers)", Pi = 0.0, estimatePi = false,
                  missing_phenotypes       = true, constraint = false,
                  estimate_variance        = true,
                  update_priors_frequency  =0,
                  #parameters for single-step analysis
                  single_step_analysis     = false,
                  pedigree                 = false,
                  #output
                  outputEBV                = true,
                  output_heritability      = false, #complete or incomplete genomic data
                  output_PEV               = false)
{
  output_samples_frequency = as.integer(output_samples_frequency)
  outputEBV = as.integer(outputEBV)

  # estimatePi = as.integer(estimatePi)

  JuliaCall::julia_call("runMCMC", model, data, estimatePi=estimatePi, chain_length = chain_length, methods = methods, output_samples_frequency = output_samples_frequency, outputEBV = outputEBV)
}

#' Run the MCMC model
#'
#' @param Pi 0.0
#' @param estimatePi FALSE
#' @param chain_length 100
#' @param burnin 0
#' @param starting_value FALSE
#' @param printout_frequency chain_length+1
#' @param missing_phenotypes FALSE
#' @param constraint FALSE
#' @param methods "conventional no markers"
#' @param output_samples_frequency 0
#' @param update_priors_frequency 0
#' @param outputEBV FALSE
#' @param single_step_analysis FALSE
#' @param pedigree FALSE
#'
#'
#'
#' @export

runMCMC = function(data, Pi=0.0, estimatePi = FALSE, chain_length = 100, burnin = 0,
                   starting_value = FALSE, printout_frequency = chain_length+1, missing_phenotypes=FALSE,
                   constraint = FALSE,methods="conventional (no markers)",output_samples_frequency = 0,
                   update_priors_frequency=0, outputEBV = FALSE,single_step_analysis=FALSE, pedigree = FALSE){

  #data
  JuliaCall::julia_assign("data", data)

  #Pi
  JuliaCall::julia_assign("Pi", Pi)

  #estimatePi
  temp_estimatePi = as.integer(estimatePi)
  JuliaCall::julia_assign("temp_estimatePi", temp_estimatePi)

  #chain_length
  JuliaCall::julia_assign("chain_length", chain_length)

  #burnin
  JuliaCall::julia_assign("burnin", burnin)

  #starting_value
  temp_starting_value = as.integer(starting_value)
  JuliaCall::julia_assign("temp_starting_value", temp_starting_value)

  #printout_frequency
  JuliaCall::julia_assign("printout_frequency", printout_frequency)

  #missing_phenotypes
  temp_missing_phenotypes = as.integer(missing_phenotypes)
  JuliaCall::julia_assign("temp_missing_phenotypes", temp_missing_phenotypes)

  #constraint
  temp_constraint = as.integer(constraint)
  JuliaCall::julia_assign("temp_constraint", temp_constraint)

  #methods
  JuliaCall::julia_assign("methods",methods)

  #output_samples_frequency
  JuliaCall::julia_assign("output_samples_frequency", output_samples_frequency)
  JuliaCall::julia_command("output_samples_frequency = Int(output_samples_frequency)")

  #update_priors_frequency
  JuliaCall::julia_assign("update_priors_frequency", update_priors_frequency)
  JuliaCall::julia_command("update_priors_frequency = Int(update_priors_frequency)")

  #single_step_analysis
  temp_single_step_analysis = as.integer(single_step_analysis)
  JuliaCall::julia_assign("temp_single_step_analysis", temp_single_step_analysis)

  #outputEBV
  temp_outputEBV = as.integer(outputEBV)
  JuliaCall::julia_assign("temp_outputEBV",temp_outputEBV)

  #pedigree
  if (pedigree == FALSE){
    JuliaCall::julia_command("out = runMCMC(model, data, Pi=Pi, estimatePi = convert(Bool,temp_estimatePi), chain_length=chain_length,burnin=burnin,starting_value=convert(Bool,temp_starting_value),printout_frequency=printout_frequency,missing_phenotypes=convert(Bool,temp_missing_phenotypes),constraint = convert(Bool,temp_constraint),methods = methods, output_samples_frequency=output_samples_frequency,update_priors_frequency=update_priors_frequency, outputEBV = convert(Bool,temp_outputEBV),single_step_analysis = convert(Bool,temp_single_step_analysis),pedigree = false)")
  } else {
    JuliaCall::julia_command("out = runMCMC(model, data, Pi=Pi, estimatePi = convert(Bool,temp_estimatePi), chain_length=chain_length,burnin=burnin,starting_value=convert(Bool,temp_starting_value),printout_frequency=printout_frequency,missing_phenotypes=convert(Bool,temp_missing_phenotypes),constraint = convert(Bool,temp_constraint),methods = methods, output_samples_frequency=output_samples_frequency,update_priors_frequency=update_priors_frequency,outputEBV = convert(Bool,temp_outputEBV),single_step_analysis = convert(Bool,temp_single_step_analysis),pedigree = pedigree)")
  }

  out=JuliaCall::julia_eval("out")
  return(out)
}







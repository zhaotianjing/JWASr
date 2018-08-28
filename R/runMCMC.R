#' Run the MCMC model
#'
#'
#' @export

runMCMC = function(data, estimatePi = FALSE, chain_length = 1000, methods="conventional (no markers)",
                   output_samples_frequency = 0, outputEBV = FALSE,single_step_analysis=FALSE, pedigree = FALSE){

  #data
  JuliaCall::julia_assign("data", data)

  #estimatePi
  temp_estimatePi = as.integer(estimatePi)
  JuliaCall::julia_assign("temp_estimatePi", temp_estimatePi)

  #chain_length
  JuliaCall::julia_assign("chain_length", chain_length)

  #methods
  JuliaCall::julia_assign("methods",methods)

  #output_samples_frequency
  JuliaCall::julia_assign("output_samples_frequency", output_samples_frequency)
  JuliaCall::julia_command("output_samples_frequency = Int(output_samples_frequency)")

  #single_step_analysis
  temp_single_step_analysis = as.integer(single_step_analysis)
  JuliaCall::julia_assign("temp_single_step_analysis", temp_single_step_analysis)

  #outputEBV
  temp_outputEBV = as.integer(outputEBV)
  JuliaCall::julia_assign("temp_outputEBV",temp_outputEBV)

  #pedigree
  if (pedigree == FALSE){
    JuliaCall::julia_command("out = runMCMC(model, data, estimatePi = convert(Bool,temp_estimatePi), chain_length=chain_length,methods = methods, output_samples_frequency=output_samples_frequency, outputEBV = convert(Bool,temp_outputEBV),single_step_analysis = convert(Bool,temp_single_step_analysis),pedigree = false)")
  } else {
    JuliaCall::julia_command("out = runMCMC(model, data, estimatePi = convert(Bool,temp_estimatePi), chain_length=chain_length,methods = methods, output_samples_frequency=output_samples_frequency, outputEBV = convert(Bool,temp_outputEBV),single_step_analysis = convert(Bool,temp_single_step_analysis),pedigree = pedigree)")
  }

  out=JuliaCall::julia_eval("out")
  return(out)
}







#' Run the MCMC model
#'
#' @param model the model built before
#' @param mydata the data upload before
#'
#' @examples
#' model_equation = "y1 = intercept + x1"
#' R = 1.0
#' model = build_model(model_equation, R)
#' runMCMC(model, phenotypes)
#'
#' @export

runMCMC = function(model, mydata, estimatePi = 0, chain_length = 1000, methods="conventional (no markers)",
                   output_samples_frequency = 0, single_step_analysis= 0, pedigree = 0, outputEBV = 0){
  JuliaCall::julia_assign("model", model)
  JuliaCall::julia_assign("mydata", mydata)
  JuliaCall::julia_assign("estimatePi", estimatePi)
  JuliaCall::julia_command("estimatePi = convert(Bool, estimatePi);")
  JuliaCall::julia_assign("chain_length", chain_length)
  JuliaCall::julia_assign("methods",methods)
  JuliaCall::julia_assign("output_samples_frequency", output_samples_frequency)
  JuliaCall::julia_command("output_samples_frequency = Int(output_samples_frequency)")
  JuliaCall::julia_assign("single_step_analysis", single_step_analysis)
  JuliaCall::julia_command("single_step_analysis = convert(Bool,single_step_analysis)")
  JuliaCall::julia_assign("pedigree", pedigree)

  JuliaCall::julia_assign("outputEBV", outputEBV)
  JuliaCall::julia_command("outputEBV = convert(Bool,outputEBV)")


  JuliaCall::julia_command("out = runMCMC(model, mydata, estimatePi = estimatePi, chain_length=chain_length,methods = methods, output_samples_frequency=output_samples_frequency,single_step_analysis = single_step_analysis,  pedigree = pedigree, outputEBV = outputEBV)")
  out=JuliaCall::julia_eval("out")
  return(out)
}








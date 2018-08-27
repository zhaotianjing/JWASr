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

runMCMC = function(model, mydata,chain_length=1000,output_samples_frequency=0){
  JuliaCall::julia_assign("model", model)
  JuliaCall::julia_assign("mydata", mydata)
  JuliaCall::julia_assign("chain_length", chain_length)
  JuliaCall::julia_assign("output_samples_frequency", output_samples_frequency)
  JuliaCall::julia_command("output_samples_frequency = Int(output_samples_frequency)")

  JuliaCall::julia_command("out = runMCMC(model, mydata,chain_length=chain_length,output_samples_frequency=output_samples_frequency)")
  out=JuliaCall::julia_eval("out")
  return(out)
}

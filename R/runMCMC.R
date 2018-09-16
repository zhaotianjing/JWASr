#' @export

runMCMC = function(model, data, estimatePi = FALSE, chain_length = 100, methods="conventional (no markers)", output_samples_frequency = 0, outputEBV = FALSE){

  output_samples_frequency = as.integer(output_samples_frequency)
  outputEBV = as.integer(outputEBV)

  # estimatePi = as.integer(estimatePi)

  JuliaCall::julia_call("runMCMC", model, data, estimatePi=estimatePi, chain_length = chain_length, methods = methods, output_samples_frequency = output_samples_frequency, outputEBV = outputEBV)
}

#' outputMCMCsamples
#'
#' @param xi String
#'
#'
#' @export

outputMCMCsamples = function(model, xi){
  JuliaCall::julia_call("outputMCMCsamples", model, xi)
}

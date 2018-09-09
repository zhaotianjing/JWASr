#' outputMCMCsamples
#'
#' @param xi String
#'
#'
#' @export

outputMCMCsamples = function(xi){
  JuliaCall::julia_call("outputMCMCsamples",JuliaCall::julia_eval("model"),xi)
}

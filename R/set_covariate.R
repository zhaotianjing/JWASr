#' Set Factors or Covariate
#'
#' @param xi String
#'
#'
#' @export


set_covariate = function(xi){
  JuliaCall::julia_call("set_covariate", JuliaCall::julia_eval("model"),xi)
}




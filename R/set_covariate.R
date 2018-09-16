#' Set Factors or Covariate
#'
#'
#'
#' @export


set_covariate = function(model, xi){
  JuliaCall::julia_call("set_covariate", model, xi)
}




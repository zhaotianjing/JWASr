#'  set covariate
#' @param xi string eg."x1"
#'
#' @export


set_covariate = function(xi){
  JuliaCall::julia_call("set_covariate", JuliaCall::julia_eval("model"),xi)
}




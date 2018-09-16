#'  Build model
#'
#' @param model_equation the model equation
#' @param R the residual value
#'
#'
#' @export

build_model = function(model_equation, R){
  JuliaCall::julia_call("build_model", model_equation, R)
}



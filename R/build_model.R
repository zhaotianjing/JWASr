#'  Build model
#'
#' @param model_equation the model equation
#' @param R the residual value
#'
#' @examples
#' model_equation = "y1 = intercept + x1"
#' R = 1.0
#' model = build_model(model_equation, R)
#'
#' @export

build_model = function(model_equation, R){
  JuliaCall::julia_assign("R", R)
  JuliaCall::julia_assign("model_equation", model_equation)
  JuliaCall::julia_command("model = build_model(model_equation, R);")
  model = JuliaCall::julia_eval("model")

  return(model)
}



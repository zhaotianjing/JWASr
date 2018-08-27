#'  set_covariate
#'
#'
#' @export

set_covariate = function(mymodel,x){

  JuliaCall::julia_assign("mymodel", mymodel)
  JuliaCall::julia_assign("x",)
  JuliaCall::julia_command("set_covariate(mymodel,x);")

}


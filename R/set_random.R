#' @export

set_random = function(xi,G,pedigree = FALSE){
  if(pedigree == FALSE){
    JuliaCall::julia_call("set_random",JuliaCall::julia_eval("model"),xi,G)
  } else {
    JuliaCall::julia_call("set_random",JuliaCall::julia_eval("model"),xi,JuliaCall::julia_eval("pedigree"),G)
  }
}








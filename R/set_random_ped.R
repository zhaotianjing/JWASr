#' @export

set_random_ped = function(model, xi,ped,G){
  
  JuliaCall::julia_call("set_random",model,xi,ped,G)
  
}
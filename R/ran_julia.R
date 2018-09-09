#' ran_julia
#'
#'
#' @export


ran_julia = function(commd){
  JuliaCall::julia_command(commd)
}

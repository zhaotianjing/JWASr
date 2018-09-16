#' Set Random or Fixed Effects
#'
#' @param model model
#' @param xi String
#' @param G number or diag matrix
#' @param pedigree FALSE or TRUE
#'
#'
#' @export

set_random = function(model, xi,G){

    JuliaCall::julia_call("set_random",model,xi,G)

}








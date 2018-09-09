#' Set up for mac user
#'
#' This function initializes Julia and the JWAS.jl package
#'
#'
#' @export
jwasr_setup <- function (){
  julia = JuliaCall::julia_setup()
  JuliaCall::julia_library("JWAS")
  JuliaCall::julia_library("CSV")
}

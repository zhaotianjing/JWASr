#' Set up
#'
#' This function initializes Julia and the JWAS.jl package
#'
#' jwasr_setup()
#'
#' @export
jwasr_setup <- function (){
  julia = JuliaCall::julia_setup()
  JuliaCall::julia_library("JWAS")
  JuliaCall::julia_library("CSV")
}

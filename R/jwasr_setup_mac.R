#' Set up
#'
#' This function initializes Julia and the JWAS.jl package
#' The first time will be long since it includes precompilation.
#'
#' jwasr_setup()
#'
#' @export
jwasr_setup <- function (){
  julia = JuliaCall::julia_setup()
  JuliaCall::julia_library("JWAS")
  JuliaCall::julia_library("CSV")
}

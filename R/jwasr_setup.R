#' Set up
#'
#' This function initializes Julia and the JWAS.jl package
#' The first time will be long since it includes precompilation.
#'
#' @param path_libjulia path of libjulia
#'
#' @examples
#' path_libjulia = "C:/Users/ztjsw/AppData/Local/Julia-0.7.0/bin/libjulia.dll"
#' jwasr_setup(path_libjulia)
#'
#' @export

jwasr_setup_win <- function (path_libjulia){
  JuliaCall:::juliacall_initialize(path_libjulia)
  julia = JuliaCall::julia_setup()
  JuliaCall::julia_library("JWAS")
  JuliaCall::julia_library("CSV")
}


jwasr_setup <- function (){
  julia = JuliaCall::julia_setup()
  JuliaCall::julia_library("JWAS")
  JuliaCall::julia_library("CSV")
}

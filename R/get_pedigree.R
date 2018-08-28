#' get pedigree from file path
#'
#' @export

get_pedigree = function(path, separator = ',', header = TRUE){

  JuliaCall::julia_assign("pedfile", path)
  JuliaCall::julia_assign("separator", separator)

  if (header == TRUE){
    JuliaCall::julia_command("pedigree = get_pedigree(pedfile, separator = separator,header = true)")

  } else {
    JuliaCall::julia_command("pedigree = get_pedigree(pedfile, separator = separator,header = false)")
  }

}




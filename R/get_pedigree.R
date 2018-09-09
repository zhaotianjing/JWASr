#' Get pedigree
#'
#' @param path String
#' @param header TRUE or FALSE
#'
#' @examples
#' ped_path = "D:\\JWASr\\data\\pedigree.txt"
#' get_pedigree(ped_path, separator=',', header=T)  #build "pedigree" in Julia

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




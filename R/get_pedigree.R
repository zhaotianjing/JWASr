#' Get pedigree
#'
#' @param path String
#' @param header TRUE or FALSE
#'
#' @examples
#' ped_path = "D:\\JWASr\\data\\pedigree.txt"
#' get_pedigree(ped_path, separator=',', header=T)  #build "pedigree" in Julia

#' @export

get_pedigree = function(path, separator = ",", header = TRUE){

  header = as.integer(header)

  JuliaCall::julia_call("get_pedigree", path, separator = separator, header = header)

}




#' Use Genomic Information
#'
#' @param path String
#' @param G_geno A number or diag matrix
#'
#' @examples
#' G3 = diag(3)
#' geno_path = "D:/JWASr/data/genotypes.txt"
#' add_genotypes(geno_path, G3)
#'
#'
#' @export


add_genotypes = function(path, G_geno){
  JuliaCall::julia_assign("genofile", path)
  JuliaCall::julia_assign("G_geno", G_geno)

  JuliaCall::julia_command("add_genotypes(model, genofile, G_geno, separator = ',')")
}










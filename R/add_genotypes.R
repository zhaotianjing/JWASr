#' add genotypes from file path
#' 
#' @export


add_genotypes = function(path, G_geno, separator = ','){
  JuliaCall::julia_assign("genofile", path)
  JuliaCall::julia_assign("G_geno", G_geno)
  JuliaCall::julia_assign("separator", separator)
  JuliaCall::julia_command("add_genotypes(model, genofile, G_geno, separator = separator)")
}

  









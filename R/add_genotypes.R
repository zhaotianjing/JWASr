#' add genotypes from file path
#' 
#' @export


add_genotypes = function(geno_path, G, separator=','){
  JuliaCall::julia_assign("genofile", geno_path)
  JuliaCall::julia_assign("G", G)
  JuliaCall::julia_assign("separator", separator)
  
  JuliaCall::julia_command("add_genotypes(model, genofile = genofile, G = G, separator = separator)")
}











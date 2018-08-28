#' add genotypes from file path
#' 
#' @export


add_genotypes = function(path, G3){
  JuliaCall::julia_assign("genofile", path)
  JuliaCall::julia_assign("G3", G3)
  

  
  JuliaCall::julia_command("add_genotypes(model, genofile, G, separator = ',')")
}

  









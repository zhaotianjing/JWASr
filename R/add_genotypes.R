#' @export

add_genotypes = function(model, path, G, separator = ",",header = T){
  if(separator==','){
    JuliaCall::julia_call("add_genotypes",model,path,G,separator = JuliaCall::julia_eval("','"),header = header)
  } else if(separator == ' ') {
    JuliaCall::julia_call("add_genotypes",model,path,G,separator = JuliaCall::julia_eval("' '"),header = header)
  }
}






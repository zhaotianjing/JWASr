#'  set_random
#'
#'
#' @export

set_random = function(mymodel2,x,g){
  
  JuliaCall::julia_assign("mymodel2", mymodel2)
  JuliaCall::julia_assign("x", x)
  JuliaCall::julia_assign("g", g)
  JuliaCall::julia_command("set_random(mymodel2,x,g);")
  
}


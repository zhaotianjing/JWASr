#'  assign
#'
#'
#' @export
#'

assign = function(object, value){


  JuliaCall::julia_assign("object", value)


}

#' assign
#' @param object object for assign
#' @param value value for assign
#'
#'
#' @examples
#' assign("R",1.0)
#'
#' @export

assign = function(object, value){


  JuliaCall::julia_assign("object", value)


}

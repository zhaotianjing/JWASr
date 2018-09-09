#' assign
#' @param object String
#' @param value String or number
#'
#'
#' @examples
#' assign("R",1.0)
#'
#' @export

assign = function(object, value){

  JuliaCall::julia_assign(object, value)

}

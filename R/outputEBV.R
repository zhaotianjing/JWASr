#' @export

outputEBV = function(ai){
  JuliaCall::julia_call("outputEBV", JuliaCall::julia_eval("model"), ai)
}

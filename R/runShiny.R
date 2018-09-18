#' @export
runShiny <- function() {
  appDir <- system.file("shiny-examples", "myapp", package = "JWASr")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `JWASr`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}

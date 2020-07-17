#' Hello function
#'
#' Here is a test function for our package.
#' It greets the user.
#' @param name The name you want to greet.
#' @export
hello <- function(name) {
  greeting <- paste0("Hello, ", name, "!")
  print(greeting)
}


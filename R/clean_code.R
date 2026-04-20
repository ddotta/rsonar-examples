#' Greet a Person
#'
#' @param name A character string with the person's name.
#' @return A greeting string.
#' @export
#' @examples
#' greet("World")
greet <- function(name) {
  if (!is.character(name) || length(name) != 1L) {
    stop("'name' must be a single character string.")
  }
  paste0("Hello, ", name, "!")
}

#' Compute Fibonacci Sequence
#'
#' @param n Number of terms to compute (positive integer).
#' @return An integer vector of length `n`.
#' @export
#' @examples
#' fibonacci(10)
fibonacci <- function(n) {
  if (!is.numeric(n) || n < 1) {
    stop("'n' must be a positive integer.")
  }
  n <- as.integer(n)
  if (n == 1L) return(0L)
  if (n == 2L) return(c(0L, 1L))
  fib <- integer(n)
  fib[1] <- 0L
  fib[2] <- 1L
  for (i in 3:n) {
    fib[i] <- fib[i - 1L] + fib[i - 2L]
  }
  fib
}

#' Compute Body Mass Index
#'
#' @param weight Weight in kilograms.
#' @param height Height in meters.
#' @return A numeric BMI value.
#' @export
#' @examples
#' bmi(70, 1.75)
bmi <- function(weight, height) {
  if (height <= 0) stop("Height must be positive.")
  if (weight <= 0) stop("Weight must be positive.")
  weight / (height^2)
}

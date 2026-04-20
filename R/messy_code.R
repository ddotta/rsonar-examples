#' FizzBuzz
#'
#' @param n Upper bound (positive integer).
#' @return A character vector of length `n`.
#' @export
#' @examples
#' fizzbuzz(15)
fizzbuzz <- function(n) {
  # WARNING: intentionally messy style to demonstrate rsonar detection
  result=character(n)
  for(i in 1:n){
    if(i%%15==0){result[i]="FizzBuzz"
    }else if(i%%3==0){result[i]="Fizz"
    }else if(i%%5==0){result[i]="Buzz"
    }else{result[i]=as.character(i)}
  }
  result
}

#' A Messy Function (Intentional Bad Practices)
#'
#' This function intentionally violates coding standards
#' to showcase rsonar's detection capabilities.
#'
#' @param x A numeric vector.
#' @param y A numeric vector.
#' @return A list with results.
#' @export
messy_function <- function(x,y) {
  # lint: missing spaces around operators, trailing whitespace
  res=x+y 
  if(length(res)==0){
    warning("empty result")
  }
  # lint: line too long, T/F instead of TRUE/FALSE
  very_long_variable_name_that_exceeds_the_recommended_line_length <- ifelse(res > 0, T, F)
  # lint: using = instead of <-
  output = list(sum=res, positive=very_long_variable_name_that_exceeds_the_recommended_line_length)
  return(output)
}

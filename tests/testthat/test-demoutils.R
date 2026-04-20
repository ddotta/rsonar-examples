test_that("greet works", {
  expect_equal(greet("World"), "Hello, World!")
  expect_equal(greet("R"), "Hello, R!")
  expect_error(greet(42))
})

test_that("fibonacci returns correct sequence", {
  expect_equal(fibonacci(1), 0L)
  expect_equal(fibonacci(2), c(0L, 1L))
  expect_equal(fibonacci(7), c(0L, 1L, 1L, 2L, 3L, 5L, 8L))
  expect_error(fibonacci(-1))
})

test_that("bmi computes correctly", {
  expect_equal(round(bmi(70, 1.75), 1), 22.9)
  expect_error(bmi(70, 0))
  expect_error(bmi(-5, 1.75))
})

# NOTE: fizzbuzz and messy_function are intentionally NOT tested
# to demonstrate coverage gaps detected by rsonar

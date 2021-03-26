##### Unit Testing in R: testthat() ####
# To illustrate unit testing in R, we will utilize the testthat package. (You get one guess as to who developed it. No, not me.)

# A part of a code base. Think of a situation where this is written off-the-cuff, without much thought.
char2int = function(character) { which(letters==character) }
# You told someone else on your development team that you wrote a function that returns an integer for each letter, e.g., “a” returns 1. That person then used test_that() to determine whether your function can be “broken.”

if ( require("testthat") == FALSE ) {
  install.packages("testthat",repos="https://cloud.r-project.org")
  library(testthat)
}
## Loading required package: testthat
## Error in get(genname, envir = envir) : object 'testthat_print' not found


test_that(desc = "Test for string of length greater than 1",expect_error(char2int("aa")))
## Error: Test failed: 'Test for string of length greater than 1'
## * `char2int("aa")` did not throw an error.


test_that(desc = "Test for improper input (numeric)",       expect_error(char2int(1)))
## Error: Test failed: 'Test for improper input (numeric)'
## * `char2int(1)` did not throw an error.


char2int = function(character) 
{ 
  if ( typeof(character) != "character" ) stop("The input must be a character.")
  if ( nchar(character) > 1 ) stop("The input character must be of length 1.")
  which(letters==character)
}
test_that(desc = "Test for string of length greater than 1",expect_error(char2int("aa")))
test_that(desc = "Test for improper input (numeric)",       expect_error(char2int(1)))
test_that(desc = "Test for expected output length (1)",     expect_length(char2int("a"),1))
test_that(desc = "Test that output is integer",             expect_type(char2int("a"),"integer"))


char2int("A")
## integer(0)
char2int(c("A","B","C"))
## Warning in if (nchar(character) > 1) stop("The input character must be of length
## 1."): the condition has length > 1 and only the first element will be used
## Warning in letters == character: longer object length is not a multiple of
## shorter object length
## integer(0)


char2int = function(character) 
{ 
  if ( typeof(character) != "character" ) stop("The input must be a character.")
  if ( length(character) != 1 ) stop("The input must be a character vector of length 1.")
  if ( nchar(character) > 1 ) stop("The input character must be of length 1.")
  which(letters==tolower(character))
}
test_that(desc = "Test for string of length greater than 1",     expect_error(char2int("aa")))
test_that(desc = "Test for improper input (numeric)",            expect_error(char2int(1)))
test_that(desc = "Test for expected output length (1)",          expect_length(char2int("a"),1))
test_that(desc = "Test that output is integer",                  expect_type(char2int("a"),"integer"))
test_that(desc = "Test that upper-case letters work",            expect_equal(char2int("A"),1))
test_that(desc = "Test that the length of the input vector is 1",expect_error(char2int(letters)))


# expect_null(): use this when you have your code return NULL rather than stop when, e.g., a bad input is detected
# expect_silent(): use this when you expect no errors, warnings, or messages
# expect_output(): use this when you want to ensure that output is not returned invisibly or is not NULL
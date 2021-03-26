###### R: Stuff Happens #####
# There are three so-called conditions in R: errors, warnings, and messages. (Note that to get the code chunk below to run, I added the option error=TRUE at the beginning. Keep this in mind for situations where your .Rmd file won’t knit.)

x = "a"
if ( typeof(x) != "numeric") stop("x must be numeric.")      # Error: communicated via stop()
## Error in eval(expr, envir, enclos): x must be numeric.
if ( typeof(x) != "numeric") warning("x should be numeric.") # Warning: communicated via warning()
## Warning: x should be numeric.
message("Welcome to the first code chunk of Notes_8B!")     # Message: communicated via message()
## Welcome to the first code chunk of Notes_8B!

# This is not necessarily good coding practice, but if you want to suppress warnings and messages…

suppressWarnings(warning("This is your final warning!"))           # ...but it isn't, probably
suppressMessages(message("You don't want to miss this message!"))  # ...but you will



##### Debugging: R Markdown & Browser() #####

h <-  function(x)
{
  # there is a host of problems thay could occur here.
  x <- -abs(x)
  log(x)
}

x = 5
#browser() # uncomment in real-life usage...execution stops here and a "Browse" prompt appears in the console
x = -abs(x)
log(x)     # only yields a warning if a negative number is input

x <- 10
browser()
# c or cont: exit the browser and continue execution at the next statement
# n: evaluate the next statement, stepping over function calls
# s: evaluate the next statement, stepping into function calls



##### Debugging: R Markdown & traceback() #####
# The traceback() function allows one to determine at what level of nested function calls an error occurs:

f <- function(a) g(a)
g <- function(b) h(b)
h <- function(c) i(c) + "a"
i <- function(d) d
f(10)
traceback()


##### Condition Handling: try() #####
# The try() function allows you to ignore errors:
  
f = function(x) { try(log(x)) } 
f(10)
## [1] 2.302585
f("x")
## Error in log(x) : non-numeric argument to mathematical function
f = function(x) { 
  try(
    {
      x = -abs(x)
      log(x)
    },silent=TRUE) # Not necessarily a good coding practice! (And only suppresses errors.)
}
f(10)
## Warning in log(x): NaNs produced
## [1] NaN
f("x")


##### Condition Handling: tryCatch() #####
f = function(x) {
  tryCatch(log(x),
           error = function(c) "Error: input is not a number.",
           warning = function(c) "Warning: input is a negative number."
  )
}
f(10)  # bueno
## [1] 2.302585
f(-10) # malo
## [1] "Warning: input is a negative number."
f("x") # muy malo
## [1] "Error: input is not a number."
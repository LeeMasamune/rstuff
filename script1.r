# My first program in R

my_string <- "Hello, World!"
print(my_string) # Variables are case sensitive!
# linter wants var and f names in snake_case

if (FALSE) { # R has no official multiline comments
   "This is a demo for multi-line comments and it should be put inside either a
      single OR double quote"
}

# assignment works with "=" but the linter doesn't like that

"The other way around" -> my_string # this also works
print(my_string)

#------------------------------------------------------------------------------#
# Basic Types
#------------------------------------------------------------------------------#

# R is dynamically typed

v <- TRUE
print(class(v))

# a complete statement may end in a semicolon or newline
v <- FALSE; print(class(v))

print(class(class(v)))  # the type of the result of the class function is
                        #     character

# an incomplete statement ending with a newline is allowed, R will read until
#     the statement is complete
v <-
      19.92
      1992; # not assigned to v, shown immediately in output
print(v) # will show "19.92"
print(class(v))

v <- 2.6 + 0i
print(v) # will show "2.6+0i"
print(class(v)) # Will resolve as complex even if 0i

# vs code linter does not like single-code strings
v <- "a"
print(class(v)) # "character"

v <- "hello"
print(class(v)) # "character", no c-like char vs string-is-char-array

v <- charToRaw(v)
print(v)
print(class(v)) # it's RAW

#------------------------------------------------------------------------------#
# Vectors                                                          Homogenized #
#------------------------------------------------------------------------------#

# Create a vector.
apple <- c("red", "green", "yellow")
print(apple)

# Get the class of the vector.
print(class(apple)) # "character", WHAT THE FUCK

# Also, R is weakly typed

v <- c(TRUE, FALSE)
print(v); print(class(v))

v <- c(TRUE, FALSE, 0L)
print(v); print(class(v))

v <- c(TRUE, FALSE, 0L, 0)
print(v); print(class(v))

v <- c(TRUE, FALSE, 0L, 0.0)
print(v); print(class(v))

v <- c(TRUE, FALSE, 0L, 0.1)
print(v); print(class(v))

v <- c(TRUE, FALSE, 0L, 0.00)
print(v); print(class(v))

v <- c(TRUE, FALSE, 0L, 0.01) # Precision affects print out of other values
print(v); print(class(v))

v <- c(TRUE, FALSE, 0L, 0, 0.000i)
print(v); print(class(v))

v <- c(TRUE, FALSE, 0L, 0, 0.001i)
print(v); print(class(v))

v <- c(TRUE, FALSE, 0L, 0.001, 0.001i) # Print out combines all precision
print(v); print(class(v))

v <- c(TRUE, FALSE, 0L, 0, 0i, "0")
print(v); print(class(v))

v <- c(TRUE, FALSE, 0L, 0, 0i, "0", charToRaw("0")) # still character
print(v); print(class(v))

v <- c(TRUE, FALSE, charToRaw("0"))
print(v); print(class(v))

# Conversion preference
# Given an item in a vector, if that has a type of (pick one below),
#     all items to the left of that type will be converted to that type
# raw >> logical >> integer >> numeric >> complex >> character

# Precision in output is additive though

v <- c(v, 1, 2, 3); # Can append vectors
print(v); print(class(v))

#------------------------------------------------------------------------------#
# Lists                                                           Heterogenous #
#------------------------------------------------------------------------------#

# Create a list.
list1 <- list(c(2, 5, 3), 21.3, sin)

# Print the list.
print(list1)
print(class(list1)) # "list"

list1 <- list(list1, v) # not append, will nest instead
print(list1)
print(class(list1)) # "list"


#------------------------------------------------------------------------------#
# Matrices                                                         Homogenized #
#------------------------------------------------------------------------------#

# Create a matrix.
m <- matrix(c("a", "a", TRUE, "c", "b", "a"), nrow = 2, ncol = 3, byrow = TRUE)
print(m)
print(class(m)) # "matrix"

# Matrices are always 2d

#------------------------------------------------------------------------------#
# Arrays                                                           Homogenized #
#------------------------------------------------------------------------------#

# Create an array.
a <- array(c("green", "yellow"), dim = c(3, 4, 2))
# dim parameter is vector(row, column, index)
print(a)
print(class(a)) # "array"

a <- array(c("green", "yellow"), dim = c(3, 4, 2, 3))
# dim parameter is vector(row, column, index1, index2)
print(a)
print(class(a)) # "array"

# Dimension specifiers above 2 just become indices in rterm output
a <- array(c("green", "yellow", TRUE), dim = c(5, 2))
print(a)
print(class(a)) # "array"

#------------------------------------------------------------------------------#
# Data Frames                                                     Heterogenous #
#------------------------------------------------------------------------------#

# Create the data frame.
bmi <- data.frame(
   gender   = c("Male", "Male", "Female"),
   height   = c(152, 171.5, 165),
   weight   = c(81, 93, 78),
   age      = c(42, 38, 26)
)
print(bmi)
print(class(bmi)) # "data.frame"

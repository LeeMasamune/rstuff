print
cat # concat and print
c # combine
list
unlist # converts list to vector
matrix
array
data.frame
seq
sum
mean
paste # note: "collapse" concats vector items
format
nchar  # length of character
toupper
tolower
substring(char_vector, int_start, int_end) # not int_start, int_length
sort # works as expected
names(object) <- vector # assigns names
apply()
gl(int_num_levels, int_count, vector_labels) # no. of labels must match param1
as.Date
str()
summary()
cbind # column bind (dataframes only?)
rbind # row bind (dataframes only?)
merge
melt
cast

# make a function #############################################################
nice <- function(arg1) {
    cat(" class: ", class(arg1), "\n")
    print(arg1)
}

a <- seq(32 + 0i, 44 + 1i)
nice(a)

nice(sum(a))
nice(mean(a))

nice(nice) # class: function

# allowed:
#   functions without parameters
#   named parameters (refer with =) and default arguments (assign with =)
# not working:
#   method overloading (functions are assigned to an object)

nicer <- function(arg1 = "Pink", arg2 = "Maggit") {
    nice(arg1)
    nice(arg2)
}

nicer(arg2 = "Hello", arg1 = "World")
nicer()

# paste each vector position then collapse per vector item
paste(c("f", "g"), "e", c("a b", " c ", "d"), sep = " ", collapse = "/")

format()    # digits, nsmall works like SAS format specifier
            # scientific is a flag
            # width is padding
            # justify is alignment

a <- c(format("hello", width = 8, justify = "c"),
        format(123.45, scientific = TRUE))
nice(a)

nchar(a)

#-----------------------------------------------------------------------------#
# Vectors                                                                     #
#-----------------------------------------------------------------------------#

v <- 6.6:12.6
v

v <- 6.6:12.7
v # ends in 12.6

v <- 3.8:11.4
v # ends in 10.8

v <- seq(6.6, 12.7, by = 0.1) # works as expected
v

# vector access is [] like in C
v[2]

v <- 1:53
v

# access using multiple indices
v[c(31, 33, 35)]
v[c(-1, -2, -3)] # negatives work, they EXCLUDE, not wrap around like in python

# access using logical indices (always starts from first element)
v[c(FALSE, TRUE)] # selects every 2nd item
v[c(FALSE, TRUE, TRUE, FALSE, TRUE)] # for every sequence of 5
                                    #     select 2nd, 3th and 5th
v <- c("Alice", "Bob", "Cassie", "Dylan", "Emma")
v[c(0, 1, 1, 0, 1)] # 0 selects nothing


#-----------------------------------------------------------------------------#
# Lists                                                                       #
#-----------------------------------------------------------------------------#

a <- list(c("Jan", "Feb", "Mar"),
            matrix(c(3, 9, 5, 1, -2, 8), nrow = 2), list("green", 12.3))
a

names(a) <- c("1st Quarter", "A_Matrix", "An Inner List")
nice(names(a))

# list access is [] like in C

a[1]

# specific name
a$A_Matrix # $ is name access
a$`1st Quarter` # use backticks use names with special characters

# new item, index is arbitrary, but in-betweens will be set to NULL
a[5] <- "Hello"
a[4] # does not exist
a[5]

b[6] <- "World" # doesn't work, b needs to exist as a list first

b <- list(1, 2, 3)

c <- c(a, b) # c merges lists

rm(b)
c # b is deep-copied

nice(unlist(c))


#-----------------------------------------------------------------------------#
# Matrices                                                                    #
#-----------------------------------------------------------------------------#

a <- matrix(c(3:14), nrow = 4, byrow = TRUE)
a

# matrix access is [] like in C
a[1, 3] # row 1 col 3

nice(a[2, ]) # all of row 2 as vector
nice(a[, 3]) # all of col 3 as vector

# operators + - * / works as expected


#-----------------------------------------------------------------------------#
# Arrays                                                                      #
#-----------------------------------------------------------------------------#

# array access is [] like in C
# indices per dimension separated by comma (use like matrix)

a <- array(c(1, 2, 3), dim = c(3, 3, 2))
a
a <- apply(a, c(1, 2), sum)
a


#-----------------------------------------------------------------------------#
# Factors                                                                     #
#-----------------------------------------------------------------------------#

# On creating any data frame with a column of text data, R treats the text 
#   column as categorical data and creates factors on it

# Create the vectors for data frame.
height <- c(132, 151, 162, 139, 166, 147, 122)
weight <- c(48, 49, 66, 53, 67, 52, 40)
gender <- c("male", "male", "female", "female", "male", "female", "male")

# Create the data frame.
input_data <- data.frame(height, weight, gender)
print(input_data)

# Test if the gender column is a factor.
print(is.factor(input_data$gender))

# Print the gender column so see the levels.
print(input_data$gender)

#
# can change order of levels by specifying the levels in the factor() function
#

gl(3, 6, labels = c("alice", "bob", "cassie"))


#-----------------------------------------------------------------------------#
# Data frames                                                                 #
#-----------------------------------------------------------------------------#

# MEGA SKIP


#-----------------------------------------------------------------------------#
# Packages                                                                    #
#-----------------------------------------------------------------------------#

.libPaths()

library()
search()


#-----------------------------------------------------------------------------#
# Data reshaping                                                              #
#-----------------------------------------------------------------------------#

# EPIC SKIP

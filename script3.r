nice <- function(p1) {
    cat(" class: ", class(p1), "\n")
    print(p1)
}

#------------------------------------------------------------------------------#
# CSV                                                                          #
#------------------------------------------------------------------------------#

data <- read.csv("input.csv")
nice(data)

str(data)
print(is.data.frame(data))
print(ncol(data))
print(nrow(data))
print(max(data$salary))

sub1 <- subset(data, salary == max(salary))
nice(sub1) # stilla dataframe

subset(data, dept == "IT")
subset(data, salary > 600 & dept == "IT")
sub1 <- subset(data, as.Date(start_date) > as.Date("2014-01-01"))

write.csv(sub1, "output1.csv")
out1 <- read.csv("output1.csv")

write.csv(sub1, "output2.csv", row.names = FALSE)
out2 <- read.csv("output2.csv")


#------------------------------------------------------------------------------#
# XLSX                                                                         #
#------------------------------------------------------------------------------#

library("xlsx")

data <- read.xlsx("input.xlsx", sheetName = "city")
data

data <- read.xlsx("input.xlsx", sheetIndex = 1)
data


#------------------------------------------------------------------------------#
# Binary files                                                                 #
#------------------------------------------------------------------------------#

# ULTRA SKIP


#------------------------------------------------------------------------------#
# XML                                                                          #
#------------------------------------------------------------------------------#

library("XML")
#library("methods") # haven't required this yet

xml1 <- xmlParse(file = "input.xml")
xml1

rootnode <- xmlRoot(xml1) # gets the RECORDS node
rootnode

rootsize <- xmlSize(rootnode)
rootsize

nice(rootnode[1]) # gets raw data for first element in rootnode ("node")
nice(rootnode[[1]]) # gets xml data for first element ("nodelist")

nice(rootnode[1][1])
nice(rootnode[1][1][1]) # results won't change

nice(rootnode[[1]][[1]]) # gets node at /EMPLOYEES/EMPLOYEE/ID
nice(rootnode[[1]][[1]][[1]]) # gets value of /EMPLOYEES/EMPLOYEE/ID

data <- xmlToDataFrame("input.xml")
data


#------------------------------------------------------------------------------#
# JSON                                                                         #
#------------------------------------------------------------------------------#

library("rjson")

data <- fromJSON(file = "input.json")
nice(data)

data <- as.data.frame(data)
nice(data)

# toJSON function also exists


#------------------------------------------------------------------------------#
# Web data                                                                     #
#------------------------------------------------------------------------------#

# GALACTIC SKIP


#------------------------------------------------------------------------------#
# Databases                                                                    #
#------------------------------------------------------------------------------#

# SERIOUS SKIP

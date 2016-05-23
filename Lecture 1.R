x<-1 #<- assignent operator: assigns a value to a symbol (nothing printing)
x # auto-printing of the value of object "x", returns you in this case the first element [1] of the vector (i.e. 1)

x<-1:20
x

# CREATE A VECTOR
x<-c(0.5, 0.6) ## numeric

x<-vector("numeric", length=10)
x

# EXPLICIT COERCION
x<-0:6
x
class(x)

as.numeric(x) #convert it in a numeric sequence
as.logical(x) #convert it into logical
as.character(x) #convert into character
as.complex(x)

x<-c("a","b" ,"c")
as.numeric(x) #cannot do this!

# LIST: MIXING CLASSES IN A VECTOR
x<-list(1,"a",TRUE,1+4i)
x #doesn't print like a vector

#---------------------------------------------#
# MATRICES: WAYS TO CREATE THEM
## 1. Specifing number of rows and columns
m<-matrix(nrow=2, ncol=3)
m
dim(m)
attributes(m)

m<-matrix(1:6,nrow=2, ncol=3) ## matrixes are built columnwise: when the first colum gets filled, than the second column is then filled
m

## 2. Transform a vector into a matrix
m<-c(1:10)
m
dim(m)<-c(2,5) ## transforms the above vector into a matrix with 2 rows and 5 columns
m

## 3. Binding rows and columns
x<-1:3
y<-10:12
m2<-cbind(x,y)
m2
rbind(x,y)

#---------------------------------------------#
# FACTORS: special type of vector to represent categorical data: order (ranked things) or not order (male and female)

x <- factor(c("yes", "yes", "no", "yes", "no"))
x
table(x) ##frequencies of levels
unclass(x) ##yes coded as 2
attr(x,"levels")

x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no")) ##specify baseline level (otherwise levels ordered in alphabetic order)
x

#---------------------------------------------#
# MISSING VALUES (NA for missing values or NaN for undefined mathematical operations.)
#is.na() ## are there missing values in an object?
#is.nan() ## test for NaN

x<-c(1,2,NA,10,3) #NA: numeric missing variable
x
is.na(x) ##third object of logical vector is TRUE
is.nan(x)

#A NaN value is also NA (missing value) but the converse is not true
x<-c(1,2,NaN,NA,4)
is.na(x)  ##third and fourth elements are TRUE
is.nan(x) ##third element is TRUE

#---------------------------------------------#
# DATA FRAMES: store tabular data. Special type of list: each column has objects of the same type, but types are not the same across columns. Matrixes have to store same class of objects. Data frames do not have to.
x <- data.frame(foo = 1:4, bar = c(T, T, F, F)) #first column foo variable, second column is bar variable
x
nrow(x) ##there are four rows
ncol(x)

#---------------------------------------------#
# NAMES OF VARIABLES
x<-1:3
names(x)
names(x) <- c("foo", "bar", "norf") ##give name to each element of the vector
x

x<-list(a=1,b=2,c=3)
x

m <- matrix(1:4, nrow = 2, ncol = 2)
m
dimnames(m) <- list(c("a", "b"), c("c", "d")) ##first row is called a and second row is called b. First column is called c and second coluns is called d
m

#---------------------------------------------#
# READING DATA
data <- read.table("food.txt")
data <-read.table()
data <-read.csv()

#---------------------------------------------#
# SUBSETTING: EXTRACT SUBSETS OF R OBJECTS 
## [ object from the same class back
## [[ extract element of a list or a data frame 
## $ element from list or data frame with names

x <- c("a", "b", "c", "c", "d", "a") ##character vector
x[1]
x[2]
x[1:4] ##subset vector x using a numeric index (1, 2 or 1:4)

x[x>"a"] ##subset (character vector) all elements larger than a
u <- x>"a" ##create a logic vector which observations are TRUE if x is bigger than a
u
x[u]

#---------------------------------------------#
# SUBSETTING LISTS
x <- list(foo = 1:4, bar = 0.6)

x[1] ## list with the sequence
x[[1]] ## just the sequence

x$bar ## all elements associated to bar

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x[c(1, 3)] ## extract the first and the third element of the list

x <- list(foo = 1:4, bar = 0.6, baz = "hello") 
name <- "foo"
x[[name]] ## computed index for ???foo??? [1]1234
x$name ## literally look for a list in x named "name". element ???name??? doesn???t exist! NULL
x$foo

x <- list(a = list(10, 12, 14), b = c(3.14, 2.81)) 
## suppose I want to extract the number 14
x[[c(1, 3)]] ## "14" is the third element of the first list
x[[c(2, 2)]] 

#---------------------------------------------#
# SUBSETTING MATRIX

x <- matrix(1:6, 2, 3) ## create a matrix with two rows and three columns, which observations are a sequence from 1 to 6
x
x[1, 2] ## element in first row and second column
x[2, 1]

x[1,] ## element in the first row
x[,2] ## element of the second column

x <- matrix(1:6, 2, 3)
x[1, 2] ## by doing so, you obtain a vector of length 1 rather than a matrix 1x1. You can avoid this by adding drop=FALSE
x[1, 2, drop = FALSE]

x <- matrix(1:6, 2, 3)
x[1,] ## vector with length 3
x[1, , drop = FALSE] ## and you get a 1x3 matrix

#---------------------------------------------#
# PARTIAL MATCHING

x <- list(aardvark = 1:5) ## create a list with an element in it called aardvark, made of a sequence 1 through 5
x$a ##  it returns me an element that matches the latter a. And you get the object associated with aardvark
x[["a"]] ## by default [[ doesn't do the partial matching like $ does. there's no element in a list that has a name "a". But there's another way...
x[["a", exact=FALSE]]

#---------------------------------------------#
# REMOVING NA (missing) OBJECTS

## 1. create a logical vector which tells you where the NA's are
## 2. remove them by sub-setting.

x<-c(1,2,NA,4,NA,5)
bad <- is.na(x)
bad ## logical vector true if there's a missing variable in x - third and fifth element are missing
!bad ## this gives me the opposite of bad

y <- c("a", "b", NA, "d", NA, "f") ##character vector with missing values
good <- complete.cases(x, y) ## which positions have both elements not missing
good ## first two positions are filled in, thid and the fifth are not

xgood<-x[good] ## subset x with non missing values
ygood<-y[good]
xgood

z<-c(NA, NA, NA, NA, NA, "f")
good2 <-complete.cases(x,z)
good2 ## only the sixth position is true

airquality[1:6,] ##select first 6 observations of the dataset "airquality" and all the variables
good<-complete.cases(airquality) ## logical vectors signaling which rows are complete; select all the vectors (columns) of the datasets for which there are no missing values
good
airquality[good, ][1:6, ] ##subset the dataset "airquality" based on the non-missing variables

#---------------------------------------------#
# VECTORIZED OPERATIONS
x<-c(1:4) ## or x<-1:4 only
y<-c(6:9)
x+y ## first element of x to first element of y. In Stata you would have to do loops, for instance
x>2 ## compare all the numbers to 2
x>=2
x==2 ## test for equality
x*y
x/y

x <- matrix(1:4, 2, 2); y <- matrix(rep(10, 4), 2, 2)
x
y ## 2x2 matrix with only 10 replicated 4 times
x * y ## element-wise multiplication
x/y

x %*% y ## true matrix multiplication

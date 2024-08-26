
# Shortcut ----------------------------------------------------------------
# New file R-script:   Ctrl + Shift + N
# Run all :            Ctrl + Shift + Enter
# Run 1 line:          Ctrl + Enter
# Comment:             Ctrl + Shift + C
# comment section:     Ctrl + Shift + R
# code chunk in R-md:  Ctrl + Alt + I
# <- :                 Alt + - 

# Operations --------------------------------------------------------------
# + - * / %% %/%
# > < <= >= == !=
# <- <<- = ->> -> 
# ! & && | ||
# %in%   :   %*% 

# Functions --------------------------------------------------------------------
# ls(): list all var
# ls(all.names = T): list all var include hidden var
# rm(var_name): remove var
# print(): character, cat(): null, paste(): character, 
#nchar(): length, grepl(): contain


# Note --------------------------------------------------------------------
# Case sensitive
# VAR_NAME: + Include letter, number, dot and underline. 
#           + Start with letter or dot. Hidden var start with dot.
#           + If start with dot can't follow by number



# Vector ------------------------------------------------------------------
vec <- c(1,2,3,4,5)
vec1 <- c("a", "b", "c", "d", "e")

0.2:10
seq(1,10,2)

vec1[1]
vec1[-1]
vec1[seq(1,length(vec1),2)]

vec > 3
any(vec >2)
all(vec >2)

vec > 1 & vec < 3 
vec > 1 && vec < 3 # <==> all(vec > 1 & vec < 3)
vec > 1 | vec < 3
vec > 1 || vec < 3 # <==> any(vec > 1 | vec < 3)

"e" %in% vec1
vec1[c(1:4)]
vec1[c(2,5)]
vec[vec >2]

vec1[5] <- "q"
vec1

length(vec)
sum(vec)
mean(vec)
median(vec)
sd(vec) #standard deviation
sort(vec)
sort(vec, T)

names(vec) <- c("a", "b", "c", "d", "e")
vec
vec["c"]

# Data Frame --------------------------------------------------------------
name <- c("A", "B", "C")
age <-  c(12, 18, 20 )

dat <- data.frame(fullname = name, age)
dat

dat[1,2]
dat[3,1]
dat[,1] #C1
dat[3,]
dat[,"fullname"] #C2
names(dat)
dat$fullname #C3

dat[, c(1,2)]
dat[dat$age>15, ]

View(dat)
data("mtcars")
View(mtcars)
head(mtcars) 
tail(mtcars, n=1)
summary(mtcars)
str(mtcars)
edit(dat)
dat <- edit(dat)




# List --------------------------------------------------------------------



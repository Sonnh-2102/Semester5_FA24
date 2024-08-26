
# Create data
age <- c(21, 45, 74, 68, 12, 75, 95, 56)
insulin <- c(16.5, 21.3, 23.1, 75.0, 57.3, 31.2, 61.9, 55.4)
data <- data.frame(age, insulin)
data
setwd("D:/Semester5_FA24/DTA301/R-src")
save(data, file="insulindata.rd")

#read data from file.txt------------------------
#data = read.table("D:/.../file.txt", header = T);

data("mtcars") # create example data

plot(age,insulin)

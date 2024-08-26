
# Note --------------------------------------------------------------------
x1 <- c(1,4,2,7,3,5)
x2 <- c(2,6,1,4,6,2)
data <- data.frame(x1,x2)
data
sum = x1 + x2
sum
data$sum = sum
data$sum2 = x1 + x2
data$sum3 = data$x1 + data$x2
data

# Histogram ---------------------------------------------------------------
# hist(var, xlab, ylab, main, xlim, ylim, col, border, prob)
# lines(density(na.omit(var)), col, lwd)
# Example
data("mtcars")
hp <- mtcars$hp
hist(mtcars$hp)
hist(hp, breaks = 10, col="blue", border = "white",
     xlab = "HP", ylab = "Number of Cars", main = "Dis of HP")
hist(hp, breaks = 10, col="blue", border = "white",
     xlab = "HP", ylab = "Probability", main = "Dis of HP",
     prob = T)
lines(density(na.omit(hp)), col = "red", lwd = 3)


# Boxplot -----------------------------------------------------------------
# boxplot(var, xlab, ylab, main, xlim, ylim, col, border, horizontal)
# boxplot(var ~ group, xlab, ylab, main, xlim, ylim, col, border, horizontal)

sec <- mtcars$qsec
boxplot(sec)
boxplot(sec, col = "blue", horizontal = T ,xlab = "second")
boxplot(sec ~ mtcars$vs, col = c("red", "blue"), horizontal = T ,xlab = "second",
        ylab = "VS",main = "SECOND")

# Plot and ScatterPlot ----------------------------------------------------
# plot(varY ~ varX, pch, main, xlab, ylab, col, lwd)
# abline (lm(varY ~ varX), col, lwd)
# scatterplot(varY ~ varX, pch, reg.line, smooth, xlab,...)
# scatterplot(varY ~ varX, | group, pch = c(), reg.line,...)
# libary(car)

plot(sec ~ hp)
plot(sec ~ hp, pch = 16, col = "blue")
abline(lm(sec ~ hp), col = "red", lwd=2)

library(car)
scatterplot(sec ~ hp)


# GGplot2 -----------------------------------------------------------------
# Include many layers 
# layer1 aes(x, y, col, shape,...)
# layer2 geom_XXX(), gemo_histogram(x), geom_point(x,y),...
# layer3 theme_XXX()
# syntax: p = ggplot(data, aes(x,y))
# add layers: p + geom_XXX() + theme_XXX()
# add labels: p+xlab()+ylab()+ggtitle()
# add limits: p+xlim()+ylim()
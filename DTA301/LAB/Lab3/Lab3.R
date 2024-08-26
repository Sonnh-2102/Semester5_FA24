install.packages("forecast")       # install, if necessary
library(forecast)


crudeoil_prod_input <- as.data.frame( read.csv("D:/FALL2022/DTA301/LeHuuPhuoc_HE163710_Lab3/crudeoil_prod.csv") )

# create a time series object
crudeoil_prod <- ts(crudeoil_prod_input[,2])

#examine the time series
plot(crudeoil_prod, xlab = "Time (months)",
     ylab = "Crude Oil production (millions of barrels)")

# check for conditions of a stationary time series
plot(diff(crudeoil_prod))
abline(a=0, b=0)

# examine ACF and PACF of differenced series
acf(diff(crudeoil_prod), xaxp = c(0, 48, 4), lag.max=48, main="")
pacf(diff(crudeoil_prod), xaxp = c(0, 48, 4), lag.max=48, main="")

# fit a (0,1,0)x(1,0,0)12 ARIMA model
arima_1 <- arima (crudeoil_prod,
                  order=c(0,1,0),
                  seasonal = list(order=c(1,0,0),period=12))
arima_1

# it may be necessary to calculate AICc and BIC 
# http://stats.stackexchange.com/questions/76761/extract-bic-and-aicc-from-arima-object
AIC(arima_1,k = log(length(crudeoil_prod)))   #BIC


# examine ACF and PACF of the (0,1,0)x(1,0,0)12 residuals
acf(arima_1$residuals, xaxp = c(0, 48, 4), lag.max=48, main="")
pacf(arima_1$residuals, xaxp = c(0, 48, 4), lag.max=48, main="")


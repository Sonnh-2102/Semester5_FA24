# install packages, if necessary
library(plyr)
library(ggplot2)
library(cluster)
library(lattice)
library(graphics)
library(grid)
library(gridExtra)

#1.	Import data in .csv file to grade_input data frame in R
grade_input = as.data.frame(read.csv("D:/FALL2022/DTA301/DSBDA_code_data/Chapter 4/grades_km_input.csv"))

#2.	Because the student ID is not used in the clustering analysis, pleas exclude that column from the k-means input matrix, kmdata
kmdata_orig = as.matrix(grade_input[,c("Student","English", "Math","Science")])
kmdata <- kmdata_orig[,2:4]
kmdata[1:10,]

#3.	Use k-means algorithm identify clusters for k = 1, 2, …, 15 . For each value of k, calculate the WSS 
wss <- numeric(15) 


#4.	Use R to loops through several k-means analyses for the number of centroids, k, varying from 1 to 15. For each k, the option nstart=25, specifies that the k-means algorithm will be repeated 25 times, each starting with k random initial centroids. The corresponding value of WSS for each k-mean analysis is stored in the wss vector
for (k in 1:15) wss[k] <- sum(kmeans(kmdata, centers=k, nstart=25)$withinss)

#5.	Using the basic R plot function, each WSS is plotted against the respective number of centroids, 1 through 15
plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within Sum of Squares") 


#6.	Summarize information with k=3
km = kmeans(kmdata,3, nstart=25)
km

#7.	Verifies that the results of wss
c( wss[3] , sum(km$withinss) )

#8.	Visualize the data and assigned clusters by ggplot2 package in R
df = as.data.frame(kmdata_orig[,2:4])
df$cluster = factor(km$cluster)
centers=as.data.frame(km$centers)

g1= ggplot(data=df, aes(x=English, y=Math, color=cluster )) + 
  geom_point() + theme(legend.position="right") +
  geom_point(data=centers, aes(x=English,y=Math, color=as.factor(c(1,2,3))), 
             size=10, alpha=.3, show_guide=FALSE)

g2 =ggplot(data=df, aes(x=English, y=Science, color=cluster )) + 
  geom_point() + 
  geom_point(data=centers, aes(x=English,y=Science, color=as.factor(c(1,2,3))), 
             size=10, alpha=.3, show_guide=FALSE)

g3 = ggplot(data=df, aes(x=Math, y=Science, color=cluster )) + 
  geom_point() +
  geom_point(data=centers, aes(x=Math,y=Science, color=as.factor(c(1,2,3))), 
             size=10, alpha=.3, show_guide=FALSE)

tmp = ggplot_gtable(ggplot_build(g1)) 

grid.arrange(arrangeGrob(g1 + theme(legend.position="none"),
                         g2 + theme(legend.position="none"),
                         g3 + theme(legend.position="none"),
                         main ="High School Student Cluster Analysis", ncol=1))
#9.	Do diagnostics with n= 2

#install.packages("devtools")
library(devtools)
library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering algorithms & visualization


setwd("/Users/ilari/Desktop/")
#df <- USArrests
#df <- read.csv("provaclusters.csv")
df <- read.csv("provaclustersa.csv", header = T, sep=";", stringsAsFactors=F)
rownames(df) <- df$sam

#df$sam<-as.factor(df$sam)
#df$sam<-as.numeric(df$sam)
str(df)

#read.table(file.choose("provaclusters.csv"), header=T, sep=";")
 df <- na.omit(df)

dfs <- scale(df[, -1])
head(dfs)


##                Murder   Assault   UrbanPop         Rape
## Alabama    1.24256408 0.7828393 -0.5209066 -0.003416473
## Alaska     0.50786248 1.1068225 -1.2117642  2.484202941
## Arizona    0.07163341 1.4788032  0.9989801  1.042878388
## Arkansas   0.23234938 0.2308680 -1.0735927 -0.184916602
## California 0.27826823 1.2628144  1.7589234  2.067820292
## Colorado   0.02571456 0.3988593  0.8608085  1.864967207

distance <-dist(dfs)
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07")) #?????

k2 <- kmeans(dfs, centers = 12, nstart = 1)
str(k2)
## List of 9
##  $ cluster     : Named int [1:50] 1 1 1 2 1 1 2 2 1 1 ...
##   ..- attr(*, "names")= chr [1:50] "Alabama" "Alaska" "Arizona" "Arkansas" ...
##  $ centers     : num [1:2, 1:4] 1.005 -0.67 1.014 -0.676 0.198 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:2] "1" "2"
##   .. ..$ : chr [1:4] "Murder" "Assault" "UrbanPop" "Rape"
##  $ totss       : num 196
##  $ withinss    : num [1:2] 46.7 56.1
##  $ tot.withinss: num 103
##  $ betweenss   : num 93.1
##  $ size        : int [1:2] 20 30
##  $ iter        : int 1
##  $ ifault      : int 0
##  - attr(*, "class")= chr "kmeans"

k2
## K-means clustering with 2 clusters of sizes 20, 30
## 
## Cluster means:
##      Murder    Assault   UrbanPop       Rape
## 1  1.004934  1.0138274  0.1975853  0.8469650
## 2 -0.669956 -0.6758849 -0.1317235 -0.5646433
## 
## Clustering vector:
##        Alabama         Alaska        Arizona       Arkansas     California 
##              1              1              1              2              1 
##       Colorado    Connecticut       Delaware        Florida        Georgia 
##              1              2              2              1              1 
##         Hawaii          Idaho       Illinois        Indiana           Iowa 
##              2              2              1              2              2 
##         Kansas       Kentucky      Louisiana          Maine       Maryland 
##              2              2              1              2              1 
##  Massachusetts       Michigan      Minnesota    Mississippi       Missouri 
##              2              1              2              1              1 
##        Montana       Nebraska         Nevada  New Hampshire     New Jersey 
##              2              2              1              2              2 
##     New Mexico       New York North Carolina   North Dakota           Ohio 
##              1              1              1              2              2 
##       Oklahoma         Oregon   Pennsylvania   Rhode Island South Carolina 
##              2              2              2              2              1 
##   South Dakota      Tennessee          Texas           Utah        Vermont 
##              2              1              1              2              2 
##       Virginia     Washington  West Virginia      Wisconsin        Wyoming 
##              2              2              2              2              2 
## 
## Within cluster sum of squares by cluster:
## [1] 46.74796 56.11445
##  (between_SS / total_SS =  47.5 %)
## 
## Available components:
## 
## [1] "cluster"      "centers"      "totss"        "withinss"    
## [5] "tot.withinss" "betweenss"    "size"         "iter"        
## [9] "ifault"


fviz_cluster(k2, data = df)


df %>%
  as.tibble() %>%
  mutate(cluster = k2$put,
         state = row.names(sam) %>%
  ggplot(aes(df, sam, color = factor(cluster), label = state)) +
  geom.text()
  
  
  
  
  
k3 <- kmeans(df, centers = 3, nstart = 25)
k4 <- kmeans(df, centers = 4, nstart = 25)
k5 <- kmeans(df, centers = 5, nstart = 25)

# plots to compare
p1 <- fviz_cluster(k2, geom = "text", data = df) + ggtitle("k = 2")
p2 <- fviz_cluster(k3, geom = "text",  data = df) + ggtitle("k = 3")
p3 <- fviz_cluster(k4, geom = "text",  data = df) + ggtitle("k = 4")
p4 <- fviz_cluster(k5, geom = "text",  data = df) + ggtitle("k = 5")

library(gridExtra)
grid.arrange(p1, p2, p3, p4, nrow = 2)





# LDA
install.packages("klaR")
install.packages("psych")
install.packages("MASS")
#install.packages("ggord")
install.packages('devtools')
devtools::install_github('fawda123/ggord')
install.packages("devtools")

library(klaR)
library(psych)
library(MASS)
library(ggord)
library(devtools)

#data("iris")
#str(iris)
         
setwd("/Users/ilari/Desktop/")
df <- read.csv("provaclusters.csv", header = T, sep=";", stringsAsFactors=F)
str(df)
df$States<-as.factor(df$States)
str(df)
         

#'data.frame':       150 obs. of  5 variables:
# $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...




ind <- sample(2, nrow(df),
              replace = TRUE,
              prob = c(0.6, 0.4))
training <- df[ind==1,]
testing <- df[ind==2,]


linear <- lda(States~., training)
linear

 pairs.panels(df[2:4],
             gap = 0,
             bg = c("red", "green", "blue", "yellow", "orange", "black" )[df$States],
             pch = 21)
 set.seed(123)


lda(States ~ ., data = training)
         
#Prior probabilities of groups:
#    setosa versicolor  virginica
# 0.3837209  0.3139535  0.3023256

         #Group means:
 #          Sepal.Length Sepal.Width Petal.Length Petal.Width
#setosa         4.975758    3.357576     1.472727   0.2454545
#versicolor     5.974074    2.751852     4.281481   1.3407407
#virginica      6.580769    2.946154     5.553846   1.9807692
#Coefficients of linear discriminants:
                   LD1        LD2
#Sepal.Length  1.252207 -0.1229923
#Sepal.Width   1.115823  2.2711963
#Petal.Length -2.616277 -0.7924520
#Petal.Width  -2.156489  2.6956343
#The proportion of trace:
#   LD1    LD2
#0.9937 0.0063



attributes(linear)
#[1] "prior"   "counts"  "means"   "scaling" "lev"     "svd"     "N"       "call"    "terms" 
#[10] "xlevels"
#$class
#[1] "lda"

par(mar=c(1,1,1,1))
p <- predict(linear, training)
ldahist(data = p$x[,1], g = training$States)

par(mar=c(1,1,1,1))
ldahist(data = p$x[,2], g = training$States)
par(mar=c(1,1,1,1))         
ldahist(data = p$x[,3], g = training$States)

         
ggord(linear, training$States, ylim = c(-20, 20))

partimat(States~., data = training, method = "lda")


partimat(States~., data = training, method = "qda")

p1 <- predict(linear, training)$class
tab <- table(Predicted = p1, Actual = training$Species)
tab


#Actual
#Predicted    setosa versicolor virginica
#  setosa         33          0         0
 # versicolor      0         26         1
 # virginica       0          1        25

sum(diag(tab))/sum(tab)


p2 <- predict(linear, testing)$class
tab1 <- table(Predicted = p2, Actual = testing$Species)
tab1
#Actual
#Predicted    setosa versicolor virginica
#  setosa         17          0         0
# versicolor      0         22         0
# virginica       0          1        24

sum(diag(tab1))/sum(tab1)
         







#PCA
#install.packages("corrr")      
#install.packages("ggcorrplot")
#install.packages("factoextra")         
#install.packages("FactoMineR")
library(corrr)
library(ggcorrplot)
library(factoextra)  
library(FactoMineR)   

setwd("/Users/ilari/Desktop/")
p1 <- read.csv("provaclusters.csv", header = T, sep=";", stringsAsFactors=F)
str(p1)
df$States<-as.factor(df$States)
str(p1)

colSums(is.na(p1))

numerical_data <- p1[,1:4]
head(numerical_data)    

data_normalized <- scale(numerical_data)
head(data_normalized)        

data.pca <- princomp(corr_matrix)
summary(data.pca)
         
corr_matrix <- cor(data_normalized)
ggcorrplot(corr_matrix)


data.pca <- princomp(corr_matrix)
summary(data.pca)


data.pca$loadings[, 1:2]         

fviz_eig(data.pca, addlabels = TRUE)

fviz_pca_var(data.pca, col.var = "black")   #???
         
fviz_cos2(data.pca, choice = "var", axes = 1:2)

fviz_pca_var(data.pca, col.var = "cos2",
            gradient.cols = c("black", "orange", "green"),
            repel = TRUE)
         
#plot 
library(ggfortify)
library(ggplot2)
setwd("/Users/ilari/Desktop/")
p1 <- read.csv("provaclusters.csv", header = T, sep=";", stringsAsFactors=F)
str(p1)
df$States<-as.factor(df$States)
str(p1)
p2 <- p1[, -5]
head(p2)
colSums(is.na(p2))

p2_pca <- prcomp(p2, 
                 scale=TRUE)
 
summary(p2_pca)


autoplot(p2_pca, 
         colour="blue")    

pca.plot <- autoplot(p2_pca,
                          data = p1,
                          colour = 'States')
  
pca.plot
         
biplot.pca <- biplot(p2_pca)
biplot.pca

plotg.pca <- plot(p2_pca, type="l")
plotg.pca

install.packages("GGally")
library(GGally)
library(raster)
library(rgdal)

setwd("/Users/ilari/Desktop/")

data2 <- read.table(file.choose("condambrid.csv"), header=T, sep=";")
ggpairs(data2)
matrix <- ggpairs(data2)
ggsave("corr.jpg", matrix, width = 15, height = 7) 
ggsave("mtcars.pdf")

#ggpairs(data2[3:5], aes(color = Altitudine, alpha = 0.5), lower = list(combo = "count"))


setwd("/Users/ilari/Desktop/")

my_data <- read.table(file.choose("ammcon.csv"), header=T, sep=";")
set.seed(1234)
dplyr::sample_n(my_data, 10)
res.aov <- aov(amm ~ samp, data = my_data)
# Summary of the analysis
summary(res.aov)

kruskal.test(weight ~ group, data = my_data)

#library(FSA)
#my_data <- read.table(file.choose("ammcon.csv"), header=T, sep=";")

Dunn=dunnTest(pain ~ drug,
         data=my_data,
         method="bonferroni")
library(multcompView)
Dunnx = Dunn$res
Dunnx
Dunnx$P.adj

library(rcompanion)
cldList(P.adj ~ Comparison,
        data = Dunnx,  threshold = 0.05, Letters=letters,  
                reversed = FALSE)






#pca
#install.packages("corrr")
library('corrr')

#install.packages("ggcorrplot")
library(ggcorrplot)

#install.packages("FactoMineR")
library("FactoMineR")

setwd("/Users/ilari/Desktop/")
data <- read.csv("ammcon.csv")
str(data)
colSums(is.na(data))

data_num <- as.factor(data)
sapply(data_num, class)  

numerical_data <- data_num[,1:1]

head(numerical_data)

data_normalized <- scale(numerical_data)
head(data_normalized)




#1way anova
df$sample<-as.factor(df$sample)
ano<-aov(ammine~sample,data=df)
TukeyHSD(ano, "sample")

cld <- multcompLetters4(ano, Tukey)
cld

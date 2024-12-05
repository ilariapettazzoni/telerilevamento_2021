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







kruskal <- kruskal.test(Met ~ Nomi, data = pi)
print(kruskal)
library(dunn.test)

# Dunn's test with Bonferroni adjustment
dunn_res <- dunn.test(pi$Met, pi$Nomi, method = "bonferroni")

# Display the results
print(dunn_res)
library(rcompanion)

# Convert Dunn’s test results into group letters
group_letters <- cldList(dunn_res$P.adjusted, 
                          comparison = dunn_res$comparisons, 
                          threshold = 0.05)

# Add group letters to the dataset
group_letters <- data.frame(group_letters)
print(group_letters)
group_letters$compact_group <- cut(group_letters$Median, 
                                    breaks = quantile(group_letters$Median, probs = seq(0, 1, by = 0.33)),
                                    labels = c("a", "b", "c"))




ano<-aov(Met~Nomi,data=pi)
tukey_res <- HSD.test(ano, "Nomi", group = TRUE, alpha = 0.05)
# Ensure that the variable is numeric
tukey_res$groups$Met <- as.numeric(tukey_res$groups$Met)

# Apply the cut function to create custom groupings
tukey_res$groups$custom_group <- cut(
  tukey_res$groups$Met, 
  breaks = quantile(tukey_res$groups$Met, probs = seq(0, 1, length.out = 4), na.rm = TRUE), 
  labels = c("a", "b", "c"), 
  include.lowest = TRUE
)

# View the updated groups
print(tukey_res$groups)

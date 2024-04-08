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




# Perform a two-way ANOVA
> anova_result <- aov(ammine ~ sample * state, data = x)
> 
> # Summarize the ANOVA results
> summary(anova_result)
             Df   Sum Sq  Mean Sq F value   Pr(>F)    
sample        1 0.000153 0.000153   0.771    0.383    
state         1 0.004189 0.004189  21.108 1.69e-05 ***
sample:state  1 0.000042 0.000042   0.212    0.647    
Residuals    76 0.015082 0.000198                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
> 

         library(agricolae)
> 
> # Perform Tukey HSD post-hoc test for the "sample" factor
> posthoc_sample <- HSD.test(anova_result, "sample")
> 
> # Print the post-hoc results for the "sample" factor
> print(posthoc_sample)
$statistics
       MSerror Df      Mean       CV       MSD
  0.0001984534 76 0.0236173 59.64844 0.0365746

$parameters
   test name.t ntr StudentizedRange alpha
  Tukey sample  20         5.192546  0.05

$means
         ammine          std r          se         Min         Max         Q25         Q50         Q75
5   0.040125473 0.0069631379 4 0.007043674 0.032256455 0.048856095 0.036438074 0.039694672 0.043382071
12  0.041366059 0.0138079903 4 0.007043674 0.027855800 0.058087939 0.031358257 0.039760249 0.049768052
13  0.019139030 0.0038150099 4 0.007043674 0.015648405 0.023745039 0.016201425 0.018581337 0.021518942
15  0.049206718 0.0085952869 4 0.007043674 0.036622184 0.056043530 0.048174148 0.052080579 0.053113149
17  0.042283727 0.0088844015 4 0.007043674 0.031367351 0.052560389 0.037971538 0.042603583 0.046915771
23  0.044583427 0.0111604757 4 0.007043674 0.031754924 0.056492776 0.037385129 0.045043003 0.052241301
28  0.035185298 0.0152361974 4 0.007043674 0.023984062 0.057333717 0.025879527 0.029711706 0.039017477
30  0.018020834 0.0031174885 4 0.007043674 0.014907465 0.020809940 0.015555405 0.018182967 0.020648396
36  0.010326362 0.0041305069 4 0.007043674 0.005156249 0.014882031 0.008270634 0.010633584 0.012689312
40  0.013758177 0.0065971686 4 0.007043674 0.007529465 0.020987595 0.008513575 0.013257824 0.018502426
53  0.007211992 0.0015925285 4 0.007043674 0.005299686 0.008992799 0.006317379 0.007277741 0.008172354
65  0.008059490 0.0002198539 4 0.007043674 0.007839439 0.008326123 0.007904157 0.008036199 0.008191531
68  0.012578493 0.0010357296 4 0.007043674 0.011254487 0.013502996 0.012010961 0.012778245 0.013345776
70  0.011033241 0.0003147824 4 0.007043674 0.010646530 0.011332119 0.010845656 0.011077157 0.011264742
71  0.013125780 0.0015973828 4 0.007043674 0.011457251 0.014734741 0.011930138 0.013155563 0.014351205
79  0.007735504 0.0012641439 4 0.007043674 0.006776463 0.009589739 0.007060059 0.007287907 0.007963352
80  0.010223205 0.0024825349 4 0.007043674 0.008203836 0.013669693 0.008530548 0.009509645 0.011202302
81  0.025318530 0.0026225477 4 0.007043674 0.022051434 0.028007783 0.023869866 0.025607451 0.027056115
120 0.025484806 0.0024799152 4 0.007043674 0.023396531 0.028348953 0.023418509 0.025096871 0.027163168
279 0.037579798 0.0162199826 4 0.007043674 0.022771611 0.057971535 0.025541096 0.034788024 0.046826726

$comparison
NULL

$groups
         ammine groups
15  0.049206718      a
23  0.044583427     ab
17  0.042283727    abc
12  0.041366059    abc
5   0.040125473    abc
279 0.037579798    abc
28  0.035185298    abc
120 0.025484806    abc
81  0.025318530    abc
13  0.019139030    abc
30  0.018020834    abc
40  0.013758177    abc
71  0.013125780    abc
68  0.012578493     bc
70  0.011033241     bc
36  0.010326362     bc
80  0.010223205     bc
65  0.008059490     bc
79  0.007735504      c
53  0.007211992      c

attr(,"class")
[1] "group"
> 








        # 1 way anova
         
         
mod=lm(ammine~state,data=x)
mod
m=tapply(x$ammine,x$state,mean)
m[1]; m[2]-m[1]; m[3]-m[1]
anova(mod)
summary(mod)
pairwise.t.test(x$ammine,x$state,p.adj="bonferroni") # t-test con correzione per test multipli secondo
boxplot(x$ammine~x$state,xlab="state",ylab="ammine",col=heat.colors(3),las=1) # disegna boxplots (uno per gruppo) con adeguate labels e colori diversi;
dev.copy2pdf(file="anova_statesboxplot.pdf")









        #////// 5/04/24
  data=read.csv("Dati braz-mondo.csv", header=T, sep=";")
 head(data)
dim(data)
df=data[1:140,4:32]

head(dfs)
head(df)

summary_stats <- summary(df) 
print(summary_stats)         
         
# Visualization - Box plot without jitter
library(ggplot2)

 # Reshape data for plotting
df_long <- tidyr::pivot_longer(df, cols = -Samples, names_to = "Compound", values_to = "Quantity")

# Box plot 
ggplot(df_long, aes(x = Compound, y = Quantity)) +
  geom_boxplot() +
  labs(title = "Box plot of Compound Quantities",
       x = "Compound",
       y = "Quantity")        
plot(pca1$li[,1],pca1$li[,2], xlab="PC1",ylab="PC2",col=data$Sam)
legend("topright", legend=unique(data$Sam), col=unique(data$Sam), pch=1)
         
#________________________DEFINITIVE ANALYSIS (AMINE, PHE, AA)

#Descriptive Statistics:         
library(ggplot2)  # For data visualization
> 
> # Assuming 'df' is your data frame containing compound quantities in different samples
> 
> # Calculate summary statistics for each compound
> summary_stats <- apply(df, 2, function(x) c(Mean = mean(x), Median = median(x), SD = sd(x)))
> print(summary_stats)

# Visualize the distribution of compound quantities using histograms
> # Iterate through each compound and create histograms
par(mfrow = c(4, 4))  # Set layout to 2 rows and 2 columns
> 
> # Assuming 'df' is your data frame containing compound quantities in different samples
> 
> # Iterate through each compound and create histograms
> for (compound in colnames(df)) {
+   hist(df[[compound]], main = paste("Histogram of", compound),
+        xlab = "Compound Quantity", col = "lightblue", border = "black")
+ }

# Load required libraries
> library(tidyr)  # For data manipulation
> 
> # Assuming 'df' is your data frame containing compound quantities in different samples
> 
> # Reshape data for box plot
> df_long <- tidyr::pivot_longer(df,1:29, names_to = "Compound", values_to = "Quantity")
> 
> # Create box plot
> ggplot(df_long, aes(x = Compound, y = Quantity)) +
+   geom_boxplot(fill = "lightblue", color = "black") +
+   labs(title = "Box plot of Compound Quantities",
+        x = "Compound",
+        y = "Quantity") +
+   theme_minimal()

#Exploratory Data Analysis (EDA):
# Correlation matrix
 cor_matrix <- cor(df[, -1])  # Calculate correlation matrix
corrplot(cor_matrix, method = "color", type = "lower", diag = FALSE, 
         title = "Correlation Matrix of Compounds")  # Plot correlation matrix  


                         
data$Samples <- as.factor(data$Samples)

# Compare compound quantities between '5.1a' and '5.1b' samples using t-test
t_test_result <- t.test(Put ~ Samples, data = data)
print(t_test_result)

# Compare compound quantities among 'Samples' using ANOVA
anova_result <- aov(Put ~ Samples, data = data)
print(summary(anova_result))         

ata$States <- as.factor(data$States)

# Compare compound quantities between '5.1a' and '5.1b' samples using t-test
t_test_result <- t.test(Put ~ States, data = data)
print(t_test_result)

# Compare compound quantities among 'Samples' using ANOVA
anova_result <- aov(Put ~ States, data = data)
print(summary(anova_result))    #significant difference!




# List to store ANOVA results
anova_results <- list()

# Iterate over each compound column (excluding the first three columns)
for (i in 4:ncol(data)) {
  compound <- colnames(data)[i]  # Get the name of the current column
  
  # Perform ANOVA for the compound
  anova_result <- aov(formula(paste(compound, "~ States")), data = data)
  
  # Extract relevant information from ANOVA summary
  anova_summary <- summary(anova_result)
  
  # Store ANOVA result in the list
  anova_results[[compound]] <- anova_summary
}

# Print ANOVA results to console
for (compound in names(anova_results)) {
  cat("ANOVA results for compound:", compound, "\n")
  print(anova_results[[compound]])
  cat("\n")
}
                       
#all significant!!!!!BUT NOT NORMALLY DISTRIBUTED ATTENZIONE


#PCA PLOT
# Install and load the necessary packages
install.packages("factoextra")
library(factoextra)

# Assuming you have already performed PCA and stored the results in pca_result

# Plot PCA results for individual samples
fviz_pca_ind(pca_result,
             geom = "point", # Use points to represent samples
             habillage = data$States, # Color samples based on states
             palette = "jco", # Color palette
             addEllipses = TRUE, # Add confidence ellipses
             legend.title = "States", # Legend title
             repel = TRUE # Avoid overlapping labels
             )
#save                         
# Install and load the necessary packages
library(ggplot2)

# Save the plot
ggsave("pca_plot.png", plot = fviz_pca_ind(pca_result,
                                           geom = "point",
                                           habillage = data$States,
                                           palette = "jco",
                                           addEllipses = TRUE,
                                           legend.title = "States",
                                           repel = TRUE),
       width = 8, height = 6, dpi = 300)
                         
                         

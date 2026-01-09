# AMMINE LIBERE

setwd("/Users/ilari/Desktop/")
x <- read.csv("statlibere.csv", header = T, sep=";", stringsAsFactors=F)
head(x)

#  sample       put        spd       spm      sum
#1    563 1.0854995 0.04115958 1.0854995 2.212159
#2    563 1.1038182 0.05473532 1.1038182 2.262372
#3    563 1.4820428 0.05558634 1.4820428 3.019672
#4    563 1.4459553 0.05753529 1.4459553 2.949446
#5    616 0.8826149 0.04777415 0.8826149 1.813004
#6    616 0.8617215 0.04136577 0.8617215 1.764809
 

#____________________________________________

# NORMALITY TEST
# p-value > 0.05, accettiamo l'ipotesi nulla: siamo di fronte a una distribuzione normale.
#p-value < 0.05, rifiutiamo l'ipotesi nulla: siamo di fronte a una distribuzione NON normale.

#Anderson-Darling test for normality
library(nortest)
ad.test(x$sum)
#data:  x$sum
#A = 1.7207, p-value = 0.0001838


#Cramer-von Mises normality test 
library(nortest)
cvm.test(x$sum)
#data:  x$sum
#W = 0.24663, p-value = 0.001346


#Lilliefors (Kolmogorov-Smirnov) test for normality
library(nortest)
lillie.test(x$sum)
#data:  x$sum
#D = 0.13645, p-value = 0.007255

#Shapiro-Francia normality test
library(nortest)
sf.test(x$sum)
#data:  x$sum
#W = 0.92137, p-value = 0.001479

#____________
#Test di analisi di omogeneità della varianza PER CAMPIONI NORMALI
# p-value > 0.05. Quindi accettiamo (o per meglio dire, non rifiutiamo) l'ipotesi nulla: le varianze sono omogenee.
#p-value < 0.05. Quindi rifiutiamo  l'ipotesi nulla: le varianze NON sono omogenee.

#Test di Bartlett
library(stats)
bartlett.test(sum ~ sample, data=x)
#data:  sum by sample
#Bartlett's K-squared = 42.162, df = 14, p-value = 0.0001165


#Test di Fligner-Killeen
library(stats)
fligner.test(sum ~ sample, data=x)
#data:  sum by sample
#Fligner-Killeen:med chi-squared = 48.675, df = 14, p-value = 1.016e-05

#____________
#Test di Levene non parametrico per campioni NON NORMALI
x$sample<-as.factor(x$sample)
library(car)
leveneTest(sum ~ sample, data = x)
#Levene's Test for Homogeneity of Variance (center = median)
#      Df F value    Pr(>F)    
#group 14  26.829 < 2.2e-16 ***
#      45                      
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Assessing Homogeneity of Variance in R
library(onewaytests)
homog.test(sum ~ sample, data = x, method = "Fligner")

#____________KRUSKAL-WALLIS + POST-HOC DUNN
library(rstatix)
library(multcompView)

# Kruskal-Wallis
kw <- kruskal.test(sum ~ sample, data = x)
cat("\n--- Kruskal-Wallis ---\n")
print(kw)

#___________ Dunn post-hoc con correzione BH
dunn <- dunn_test(x, sum ~ sample, p.adjust.method = "BH")

# Calcolo lettere di significatività
pw <- dunn %>%
  select(group1, group2, p.adj) %>%
  mutate(comp = paste(group1, group2, sep = "-"))

letters <- multcompLetters(setNames(pw$p.adj, pw$comp))$Letters

cat("\n--- Lettere di significatività (CLD) ---\n")
print(letters)






#___________1way anova omoschedas
ano<-aov(sum~sample, data=x)
x$sample<-as.factor(x$sample)
Tukey<-TukeyHSD(ano, "sample")
cld<-multcompLetters4(ano,Tukey, threshold = 0.05)
cld
#$sample
# 459  615  358  907  738  671  563  736  431  616  524  322  332  727  613 
# "a"  "a"  "a" "ab" "ab" "bc" "bc"  "c" "cd" "cd" "de" "de"  "e"  "e"  "e" 





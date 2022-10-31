install.packages("GGally")
library(GGally)
library(raster)
library(rgdal)

setwd("/Users/ilari/Desktop/")

data2 <- read.table(file.choose("condambrid.csv"), header=T, sep=";")
matrix <- ggpairs(data2)
ggsave("corr.jpg", matrix, width = 15, height = 7) 
ggsave("mtcars.pdf", )

ggpairs(data2[3:5], aes(color = Altitudine, alpha = 0.5), lower = list(combo = "count"))

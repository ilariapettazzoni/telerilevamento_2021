#R_code_no2.r
library(raster)
library(RStoolbox)


#1. Set the Working Directory EN

setwd("/Users/ilari/Desktop/lab/EN")

# 2. Import the first image (single band)

EN01 <- raster("EN_0001.png")
# 3. plot with preferred colorRampPalette

cl <- colorRampPalette(c("blue","green","yellow")) (100)
plot(EN01, col=cl)

#4. import the last image and plot with with the same ColorRampPalette
EN013 <- raster("EN_0013.png")



#5.difference between the 2 images and plot
ENdif<- EN013 - EN01
plot(ENdif)

ENdiff<- EN01 - EN013
plot(ENdiff)

#6. plot everything
par(mfrow=c(3,1))
plot(EN01, col=cl, main="NO2 in January")
plot(EN013, col=cl, main="NO2 in March")
plot(ENdiff, col=cl, main="Difference (January - March)")

#7. Import the whole set

rlist <- list.files(pattern="EN")
rlist

import <- lapply(rlist,raster)
import

EN <- stack(import)

plot(EN)


# 8. Replicate the plot of images 1 and 13 using the stack
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

#9. Compute a PCA over 13 images

ENpca <- rasterPCA(EN)

summary(ENpca$model)

plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")



# R_code_Sea_Surface_Temperature.r


library(raster)
library(RStoolbox)

setwd("/Users/ilari/Desktop/lab/SST")

SST03 <- raster("SST_july2003.png")
plot(SST03)

cl <- colorRampPalette(c("blue","red","black")) (100)
plot(SST03, col=cl)

library(RColorBrewer)
cols <- brewer.pal(3, "BuGn")
pal <- colorRampPalette(cols)
plot(SST03, col=pal(20))


plot(SST03, col=cl)

SST21 <- raster("SST_june2021.png")


SSTdiff<- SST21 - SST03
plot(SSTdiff)


SSTdiffe<- SST03 - SST21
plot(SSTdiffe)

#6. plot everything
par(mfrow=c(3,1))
plot(EN01, col=cl, main="NO2 in January")
plot(EN013, col=cl, main="NO2 in March")
plot(ENdiff, col=cl, main="Difference (January - March)")

#7. Import the whole set

rlist <- list.files(pattern="SST")
rlist

import <- lapply(rlist,raster)
import

SST <- stack(import)

plot(SST)


# 8. Replicate the plot of images 1 and 13 using the stack
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

#9. Compute a PCA over 13 images

ENpca <- rasterPCA(EN)

summary(ENpca$model)

plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")



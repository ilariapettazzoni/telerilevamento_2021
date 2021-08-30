#R_code_vegetation_indices.r

library(raster)
setwd("/Users/ilari/Desktop/lab")

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
# b1 = NIR, b2 = red, b3 = green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# R_code_spectral_signatures.r

#FIRME SPETTRALI  posso risalire al tipo di materiale o addirittura al tipo di pianta 
#foglie molto diverse e presentano delle firme spettrali diverse, riflettono a lunghezze d’onda differenti. 

library(raster)
library(rgdal)

setwd("/Users/ilari/Desktop/lab/")
defor2 <- brick("defor2.jpg")

plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

#La funzione click del pacchetto rgdal mi permette di ottenere informazioni cliccando su vari punti dell’immagine, in questo caso info sulla riflettanza. 
defor2
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#results:
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 348.5 229.5 178165      215        5       18
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 410.5 256.5 158868      168      141      114


band <- c(1,2,3)
forest <- c(215,5,18)
water <- c(168,141,114)
spectrals <- data.frame(band,forest,water)
attach(spectrals)
spectrals

ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=forest), color="green")

    
ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=forest), color="green") +
 geom_line(aes(y=water), color="blue") +
 labs(x="wavelength", y="reflectance")

#multitemporal
    
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

plotRGB(defor1, r=1, g=2, b=3, stretch="hist")
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
# x     y   cell defor1.1 defor1.2 defor1.3
#1 233.5 219.5 184446      213       13       26
 #    x     y  cell defor1.1 defor1.2 defor1.3
#1 22.5 353.5 88559      141       85       72

plotRGB(defor2, r=1, g=2, b=3, stretch="hist")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 115.5 252.5 161441      188       10       24
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 23.5 352.5 89649      190      176      173


# define the columns of the dataset:
band <- c(1,2,3)
time1 <- c(213,13,26)
time2 <- c(141,85,72)

spectralst <- data.frame(band, time1, time2)



# plot the sepctral signatures
ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time2), color="gray") +
 labs(x="band",y="reflectance")
 
 
 # define the columns of the dataset:
band <- c(1,2,3)
time1 <- c(223,11,33)
time1p2 <- c(218,16,38)
time2 <- c(197,163,151)
time2p2 <- c(149.157,133)

 

spectralst <- data.frame(band, time1, time2, time1p2, time2p2)

 # plot the sepctral signatures
ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time1p2), color="red") +
 geom_line(aes(y=time2), color="gray") +
 geom_line(aes(y=time2p2), color="gray") +
 labs(x="band",y="reflectance")


 



 


#R_code_copernicus.r
#Visualizing Copernicus Data
#libreria per leggere il formato nc

install.packages("ncdf4")
library(ncdf4)
library(raster)
setwd("/Users/ilari/Desktop/lab")

test <- raster("c_gls_SWI1km_202108181200_CEURO_SCATSAR_V1.0.1.nc")
#la risoluzione è in gradi, non in metri, sono quindi coordinate geografiche.
#il sistema di riferimento è il WGS84

plot(test)
clt <- colorRampPalette(c("dark green","green","white"))(100)
plot(test, col=clt)

#resampling: ricampionamento lineare, riduco i pixel
#questo dato si può ricampionare per ottenerne uno con pixel più grandi e alleggerirlo.
#per ricampionare l'immagine uso la funzione aggregatetestsam<- aggregate(test, fact=10)
plot(testsam, col=clt)
#questo tipo di ricampionamento di chiama bilineare, prende 2 line di pixel e fa la media dei pixel all'interno.


install.packages("knitr")
install.packages("RStoolbox")
library(knitr)
library(RStoolbox)

ext <- c(6, 20, 35, 50)
testc <- crop(test, ext)
plot(testc)



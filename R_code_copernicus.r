#R_code_copernicus.r
#Visualizing Copernicus Data
#libreria per leggere il formato nc

install.packages("ncdf4")
library(ncdf4)
library(raster)

test <- raster("~/Downloads/c_gls_LST10-TCI_202104010000_GLOBE_GEO_V2.1.1.nc")

plot(test)

ext <- c(6, 20, 35, 50)
testc <- crop(test, ext)
plot(testc)

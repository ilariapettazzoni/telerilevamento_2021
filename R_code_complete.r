#R_code_complete.r -Telerilevamento Geoecologico
#-----------------------------------------------

#Summary:

# 1 - Remote Sensing First Code
# 2 - Remote Code Time Series
# 3 - R Code Copernicus
# 4 - R Code Kintr
# 5 - R Code Multivariate Analysis
# 6 - R Code Classification
# 7 - R Code ggplot2
# 8 - R Code Vegetation Indices
# 9 - R Code Land Cover
# 10 - R Code Variability
#-----------------------------------------------

# 1 - Remote Sensing First Code

# My first code in R for remote sensing!

setwd("/Users/ilari/Desktop/lab/")

# nella lezione precedente install.packages("raster")

library(raster)
p224r63_2011<-brick("p224r63_2011_masked.grd")
p224r63_2011

plot(p224r63_2011)

#colour change
cl <- colorRampPalette(c("black","grey","light grey")) (100)
plot(p224r63_2011, col=cl)

cls <- colorRampPalette(c("yellow","light green","blue")) (200)
plot(p224r63_2011, col=cls)

#LEZIONE 3

library(raster)
setwd("/Users/ilari/Desktop/lab/")
p224r63_2011<-brick("p224r63_2011_masked.grd")

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

# dev.off will clean the current graph
dev.off()
plot(p224r63_2011$B1_sre)

cls <- colorRampPalette(c("orange","yellow","light green")) (200)
plot(p224r63_2011$B1_sre, col=cls)

# 1 riga e 2 colonne
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 2 righe e una colonna
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# par(mfcol=c(1,2) dichiaro prima il numero di colonne


par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

par(mfrow=c(2,2))
clb <- colorRampPalette(c("dark blue","blue","light blue")) (200)
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green")) (200)
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink")) (200)
plot(p224r63_2011$B3_sre, col=clr)

cln <- colorRampPalette(c("orange","yellow","white")) (200)
plot(p224r63_2011$B4_sre, col=cln)


# LEZIONE 4
# Visualizing data by RGB plotting

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#pdf
pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()


plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Hist")

#par natural colours, false colours, false colours with histogram stretch

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Hist")

install.packages("RStoolbox")
library(RStoolbox)

# LEZIONE 5
# Multitemporal set

library(raster)
setwd("/Users/ilari/Desktop/lab/")

p224r63_2011<-brick("p224r63_2011_masked.grd")
p224r63_2011

p224r63_1988<-brick("p224r63_1988_masked.grd")
p224r63_1988

plot(p224r63_1988)

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Hist")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Hist")

#-----------------------------------------------
# 2 - Remote Code Time Series

# LEZIONE 07/04/21

#Time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

library(raster)
setwd("/Users/ilari/Desktop/lab/greenland")

install.packages("rasterVis")
library(rasterVis)
#importo le immagini singolarmente perchè sono 4
#(non posso usare brick)
#LST= Land Surface Temperature
#uso la fuzione raster invece di brick

lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

# par
# visualizzo le 4 immagini assieme
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#per importare tutte le immagini assieme
#uso la funzione lapply, ma prima creo la lista di file (list.files)a cui applicare la funzione raster
#i file hanno in comune le lettere "lst" nel nome
 
# list f files:
rlist <- list.files(pattern="lst")
rlist
# R mi restituisce la lista dei file

#lapply(x,fan) con x=lista e fan=funzione da applicare
import <- lapply(rlist,raster)
import
#R mi restituisce le info dei 4 file importati

#ora impacchettiamo  file  con la funzione stack

TGr <- stack(import)
TGr
plot(TGr)

#funzione RGB
plotRGB(TGr, 1, 2, 3, stretch="Lin") 
plotRGB(TGr, 2, 3, 4, stretch="Lin") 
plotRGB(TGr, 4, 3, 2, stretch="Lin") 

#LEZIONE 09/04/21

#plottiamo i dati di copernicus assieme
levelplot(TGr)
#plot grafico prima immagine
levelplot(TGr$lst_2000)
#cambio colore
#col.regions per levelplot
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
#uso col.regions per levelplot
levelplot(TGr, col.regions=cl)

#rinomino gli attributi
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#inserisco il titolo del grafico
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# Melt
meltlist <- list.files(pattern="melt")
melt_import <- lapply(meltlist,raster)
melt <- stack(melt_import)
melt

levelplot(melt)
#sottrazione tra l'ultimo e il primo dato per ottenere il livello di scioglimento, il $ lega lo stack allo strato interno 

melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

#dal blu al rosso aumenta lo scioglimento
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)

levelplot(melt_amount, col.regions=clb)

#installo il pacchetto knitr
install.packages("knitr")

#-----------------------------------------------

#3 - R Code Copernicus

#R_code_copernicus.r
#Visualizing Copernicus Data
#libreria per leggere il formato nc

install.packages("ncdf4")
library(ncdf4)
library(raster)
setwd("/Users/ilari/Desktop/lab")

test <- raster("c_gls_SWI1km_202108181200_CEURO_SCATSAR_V1.0.1.nc")

plot(test)
clt <- colorRampPalette(c("dark green","green","white"))(100)
plot(test, col=clt)
#resampling: ricampionamento lineare, riduco i pixel
testsam<- aggregate(test, fact=10)
plot(testsam, col=clt)

install.packages("knitr")
install.packages("RStoolbox")
library(knitr)
library(RStoolbox)

ext <- c(6, 20, 35, 50)
testc <- crop(test, ext)
plot(testc)

#-----------------------------------------------

# 4 - R Code Kintr

#LEZIONE 16/04/21

#R_code_knitr.r

setwd("/Users/ilari/Desktop/lab/")
library(knitr)

# starting from the code folder where framed.sty is put!

require(knitr)
stitch("R_code_greenland.tex", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

install.packages("tinytex")
library(tinytex)
#non fuziona


#-----------------------------------------------

# 5 - R Code Multivariate Analysis

#R_code_multivariate_analysis

library(raster)
library(RStoolbox)

setwd("/Users/ilari/Desktop/lab")

p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
p224r63_2011
#plottiamo la banda 1 contro la banda 2
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
#le bande invertite invertono gli assi
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)

#per plottare tutte le variabili possibili, mette in correlazione tutte le variabili a due a due del dataset
pairs(p224r63_2011)

#LEZIONE 28/04/21

library(raster)
library(RStoolbox)

setwd("/Users/ilari/Desktop/lab")

p224r63_2011 <- brick("p224r63_2011_masked.grd")
pairs(p224r63_2011)
p224r63_2011

# aggregate cells: resampling (ricampionamento)del dato per avere una risoluzione più bassa e un dato più leggero
# perchè la PCA è un processo lungo e complesso, alleggeriamo per rendere meno pesante il dato

p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

#rasterPCA prende il pachetto di dati e lo compatta in un numero minore di bande
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

#chiediamo info sul modello, usiamo $model
summary(p224r63_2011res_pca$model)

plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

#-----------------------------------------------

# 6 - R Code Classification


#R_code_classification.r
#LEZIONE 21/04/21

library(raster)
library(RStoolbox)

setwd("/Users/ilari/Desktop/lab")
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
so
#visualize RGB levels
plotRGB(so, 1,2,3, stretch="lin")

#Unsupervised Classification
soc <- unsuperClass(so, nClasses=3)
#uso $map perchè abbiamo anche il modello all'interno
plot(soc$map)
#per avere lo stesso  tipo di classificazione
set.seed(42)
#Unsupervised Classification 20 classes
sov <- unsuperClass(so, nClasses=20)
#uso $map perchè abbiamo anche il modello all'interno
plot(sov$map)


sun <- brick("The_Sun_viewed_by_Solar_Orbiter_s_PHI_instrument_on_18_June_2020_pillars.png")
sun
plotRGB(sun, 1,2,3, stretch="lin")
sunc <- unsuperClass(sun, nClasses=20)
#uso $map perchè abbiamo anche il modello all'interno
plot(sunc$map)

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soc20$map,col=cl)

#LEZIONE 23/04/21
# Download Solar Orbiter data and proceed further!

# Grand Canyon
# https://landsat.visibleearth.nasa.gov/view.php?id=80948

# When John Wesley Powell led an expedition down the Colorado River and through the Grand Canyon in 1869, he was confronted with a daunting landscape. At its highest point, the serpentine gorge plunged 1,829 meters (6,000 feet) from rim to river bottom, making it one of the deepest canyons in the United States. In just 6 million years, water had carved through rock layers that collectively represented more than 2 billion years of geological history, nearly half of the time Earth has existed.

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")

gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)

gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)


#-----------------------------------------------

# 7 - R Code ggplot2

 
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("~/lab/")
p224r63 <- brick("p224r63_2011_masked.grd")
ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")
p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")
grid.arrange(p1, p2, nrow = 2) # this needs gridExtra


#-----------------------------------------------

# 8 - R Code Vegetation Indices

#R_code_vegetation_indices.r

library(raster)
#si può usare anche require(raster)
install.packages("rasterdiv")
#library(rasterdiv) # for the worldwide NDVI
library (rasterdiv)
setwd("/Users/ilari/Desktop/lab")

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
# b1 = NIR, b2 = red, b3 = green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

defor1

# difference vegetation index

# time 1
#NIR-Red
dvi1 <- defor1$defor1.1 - defor1$defor1.2

# dev.off()
plot(dvi1)


cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

plot(dvi1, col=cl, main="DVI at time 1")

# time 2
dvi2 <- defor2$defor2.1 - defor2$defor2.2

plot(dvi2, col=cl, main="DVI at time 2")

par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

difdvi <- dvi1 - dvi2
# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)


# ndvi
# (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)

# ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
# plot(ndvi1, col=cl)

ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

# ndvi1 <- dvi2 / (defor2$defor2.1 + defor1$defor2.2)
# plot(ndvi2, col=cl)

difndvi <- ndvi1 - ndvi2
# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)


# RStoolbox::spectralIndices
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi1, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)


#LEZIONE 05/05/21
# worldwide NDVI
plot(copNDVI)


# Pixels with values 253, 254 and 255 (water) will be set as NA’s.
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
library (rasterVis)
# rasterVis package needed:
levelplot(copNDVI)


#-----------------------------------------------
# 9 - R Code Land Cover

# R_code_land_cover.r

library(raster)
library(RStoolbox) # classification
# install.packages("ggplot2")
library(ggplot2)
# install.packages("gridExtra")
library(gridExtra) # for grid.arrange plotting

setwd("/Users/ilari/Desktop/lab")
# NIR 1, RED 2, GREEN 3

defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")


defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#LEZIONE 07/05/21
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)


# unsupervised classification
d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map)
# class 1: forest
# class 2: agriculture
# set.seed() would allow you to attain the same results ...

d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
# class 1: agriculture
# class 2: forest

d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

# frequencies
freq(d1c$map)
#   value  count
# [1,]     1 306583
# [2,]     2  34709

s1 <- 306583 + 34709



prop1 <- freq(d1c$map) / s1
# prop forest: 0.8983012
# prop agriculture: 0.1016988

s2 <- 342726
prop2 <- freq(d2c$map) / s2
# prop forest: 0.5206958
# prop agriculture: 0.4793042

# build a dataframe
cover <- c("Forest","Agriculture")
percent_1992 <- c(89.83, 10.16)
percent_2006 <- c(52.06, 47.93)

percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

# let's plot them!
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

grid.arrange(p1, p2, nrow=1)


#-----------------------------------------------

# 10 - R Code Variability
 
# R_code_variability.r
#LEZIONE 19/05/21

library(raster)
library(RStoolbox)
# install.packages("RStoolbox")
library(ggplot2) # for ggplot plotting
library(gridExtra) # for plotting ggplots together
# install.packages("viridis")
library(viridis) # for ggplot colouring


setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

sent <- brick("sentinel.png")
# NIR 1, RED 2, GREEN 3
# r=1, g=2, b=3
plotRGB(sent, stretch="lin") 
# plotRGB(sent, r=1, g=2, b=3, stretch="lin") 

plotRGB(sent, r=2, g=1, b=3, stretch="lin") 

nir <- sent$sentinel.1
red <- sent$sentinel.2

ndvi <- (nir-red) / (nir+red)
plot(ndvi)
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd3, col=clsd)

# mean ndvi with focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clsd)

# changing window size
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd13, col=clsd)

ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd)

# PCA
sentpca <- rasterPCA(sent) 
plot(sentpca$map)  

summary(sentpca$model)

# the first PC contains 67.36804% of the original information


pc1 <- sentpca$map$PC1

pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(pc1sd5, col=clsd)

# pc1 <- sentpca$map$PC1
# pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
# plot(pc1sd7)

# With the source function you can upload code from outside!
source("source_test_lezione.r")
source("source_ggplot.r")

# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
# The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties - “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”.
p1 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")

p2 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma")  +
ggtitle("Standard deviation of PC1 by magma colour scale")

p3 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "turbo")  +
ggtitle("Standard deviation of PC1 by turbo colour scale")

grid.arrange(p1, p2, p3, nrow = 1)

                    #Poyang Lake
                                                                   
#Poyang Lake, in China’s Jiangxi Province, routinely fluctuates in size between the winter and summer seasons. 
#In winter, water levels on the lake in are typically low. Then, summer rains cause the country’s largest freshwater lake to swell as water flows in from the Yangtze River.
#The lake has not swelled in the summer of 2022. 
#A prolonged heat wave and drought across much of the Yangtze River Basin dried the lake out early and pushed water levels to lows not seen in decades.

#The Operational Land Imager (OLI) on Landsat 8 acquired these pairs of images on July 10, 2022 (left images), and August 27, 2022 (right images). 
#The images are composites, and combine OLI observations of shortwave infrared, near infrared, and visible light.

                                                                   ------------------------

# Caricamento delle library necessarie al funzionamento dei codici :
library(raster)                                # permette l'utilizzo dei raster e funzioni annesse
library(rasterVis)                             # permette di visualizzare matrici e fornisce metodi di visualizzazione per i dati raster --> con questa libreria posso utilizzare la funzione levelplot
library(RStoolbox)                             # permette l'uso della Unsupervised Classification
library(ggplot2)                               # permette l'uso delle funzioni ggplot
library(gridExtra)                             # permette l'uso e creazione di griglie, tabelle e grafici
library(rgdal)                                 # per le firme spettrali
library(grid)                                  # Il pacchetto grid in R implementa le funzioni grafiche primitive che sono alla base del sistema di plottaggio ggplot2
library (rasterdiv)                            # Per calcolare indici di diversità e matrici numeriche

# Settaggio della working directory 
setwd("/Users/ilari/Desktop/lab/Esame/")

#Importazione immagini
poyangJ <- brick("poyang_oli_2022191_lrg.jpg") # July
poyangA <- brick("poyang_oli_2022239_lrg.jpg")# August

#Plottaggio 2 immagini colori naturali
par(mfrow=c(1,2))
plotRGB(poyangJ, r=1, g=2, b=3, stretch="lin")
plotRGB(poyangA, r=1, g=2, b=3, stretch="lin")

# Plot stretch istogramma
par(mfrow=c(1,2))
plotRGB(poyangJ, r=3, g=2, b=1, stretch="hist")
plotRGB(poyangA, r=3, g=2, b=1, stretch="hist")


#Crop immagini per maggior dettaglio
ext1 <- c(600, 3000, 2000, 20000)        # coordinate (long ovest, long est, lat sud, lat nord)
ext2 <- c(600, 3000, 2000, 20000)        # coordinate (long ovest, long est, lat sud, lat nord)

pjcropped <- crop(poyangJ, ext1)
pacropped <- crop(poyangA, ext2)

#Salvo le immagini /////// Non lanciare su R
jpeg("pjcropped.jpg")
plotRGB(pjcropped, r=1, g=2, b=3, stretch="lin")
dev.off()

jpeg("pacropped.jpg")
plotRGB(pacropped, r=1, g=2, b=3, stretch="lin")
dev.off()
//////////////////////////////////////////////

#Importazione immagini
PJulyc <- brick("pjcropped.jpg")
PAuguc <- brick("pacropped.jpg")

#Plot immagini Croppate
par(mfrow=c(1,2)) 
plotRGB(PJulyc, r=1, g=2, b=3, stretch="lin")
plotRGB(PAuguc, r=1, g=2, b=3, stretch="lin")

#LEVELPLOT
# ora applichiamo l'algebra applicata alle matrici 
#utilizzo raster perchè non mi interessa ad avere le 3 bande divise ma una immagine con un'unica banda 
poyang1 <- raster("poyang_oli_2022191_lrg.jpg") # July
poyang2 <- raster("poyang_oli_2022239_lrg.jpg")# August

#vogliamo fare la sottrazione tra il primo e l'ultimo dato 
Pwater <- poyang1 - poyang2
# creo una nuova colour palette 
clb <- colorRampPalette(c("red","pink","light blue", "white"))(100)
#jpeg("Pwater.jpg")
plot(Pwater, col=clb) # zone rosse no acqua
#dev.off()
# usiamo level per avere una gamma di colori più dettagliata 
#jpeg("Lwater.jpg")
levelplot(Pwater, col.regions=clb, main="Water level drop between July 10 2022  and August 27 2022")
#dev.off()

# UNSUPERVISED CLASSIFICATION
#si chiama così perchè è il software che scegli random un campione di pixel nell'immagine da dividere in classi

set.seed(42)

#effettuiamo una categorizzazione in 6 classi di colore per distinguere le zone con vegetazione, con acqua e "altro"
ClP1 <- unsuperClass(poyangJ, nClasses=6)  
ClP2 <- unsuperClass(poyangA, nClasses=6)  
colo <- colorRampPalette(c('yellow','orange','red','green','blue','purple'))(100) 

# metto le immagini insieme per avere una mappa della situazione 
par(mfrow=c(2,2)) 
plot(ClP1$map, col=colo)
plot(ClP2$map, col=colo)
plotRGB(poyangJ, r=1, g=2, b=3, stretch="lin")
plotRGB(poyangA, r=1, g=2, b=3, stretch="lin")

jpeg("class2.jpg")
plot(ClP2$map, col=colo)
dev.off()

#Calcolo la frequenza dei pixel delle classi

set.seed(42)
plot(ClP1$map)
freq(ClP1$map)  
#   value   count
#[1,]     1 3471646 - vegetazione, altro
#[2,]     2 9230548 - foresta
#[3,]     3 1145575 - letto + nuvole
#[4,]     4 4843234 - acqua
#[5,]     5 2528980 - vegetazione, altro
#[6,]     6 6347834 - vegetazione, altro

set.seed(42)
plot(ClP2$map)
freq(ClP2$map)  
#. value    count
#[1,]     1  3098838 - vegetazione, altro
#[2,]     2  3766096 - vegetazione, altro
#[3,]     3  1007263 - acqua
#[4,]     4 12447007 - foresta
#[5,]     5  4851411 - vegetazione, altro
#[6,]     6  2397202 - letto + nuvole


# ora calcoliamo la proporzione 
#facciamo la somma dei valori 
s1 <- 3471646 + 9230548 + 1145575 + 4843234 + 2528980 + 6347834
s1 # [1] 27567817, questo valore deve essere uguale per tutti 

s2 <- 3098838 + 3766096 + 1007263 + 12447007 + 4851411 + 2397202
s2 #[1] 27567817

#per calcolare la proporzione facciamo la frequenza fratto il totale
prop1 <- freq(ClP1$map)/ s1
prop1
#       value      count
#[1,] 3.627418e-08 0.12593112
#[2,] 7.254836e-08 0.33483057
#[3,] 1.088225e-07 0.04155480
#[4,] 1.450967e-07 0.17568435
#[5,] 1.813709e-07 0.09173668
#[6,] 2.176451e-07 0.23026248

prop2 <- freq(ClP2$map) / s2
prop2

#  value      count
# [1,] 3.627418e-08 0.08841360
# [2,] 7.254836e-08 0.03388179
# [3,] 1.088225e-07 0.45612027
# [4,] 1.450967e-07 0.13425963
# [5,] 1.813709e-07 0.11243596
# [6,] 2.176451e-07 0.17488875


perc_sand_1 <- 1145575 * 100 / 27567817
perc_sand_1
#[1] 4.15548
perc_wat_1 <- 4843234 * 100 / 27567817
perc_wat_1
#[1] 17.56843
perc_veg_1 <- (3471646 + 9230548 + 2528980 + 6347834) * 100 / 27567817
perc_veg_1
#[1] 78.27609
perc_sand_2 <- 2397202 * 100 / 27567817
perc_sand_2
#[1] 8.695654
perc_wat_2 <- 1007263 * 100 / 27567817
perc_wat_2 
#[1] 3.653764
perc_veg_2 <- (3098838 + 3766096 + 12447007 + 4851411) * 100 / 27567817
perc_veg_2
#[1] 87.65058

cover <- c("acqua","sabbia","vegetazione")
July_10 <- c(17.64645, 4.487715, 78.27609)
August_28 <- c(3.388179, 8.84136, 87.65058)


# per crare il nostro data Frames uso la funzione data.frame
percentages <- data.frame(cover, July_10, August_28)
percentages
#        cover July_10 August_28
#1       acqua  17.646450   3.388179
#2        dune   4.487715   8.841360
#3 vegetazione  78.276090  87.650580


v<-ggplot(percentages, aes(x=cover, y=July_10, color=cover)) + geom_bar(stat="identity", fill="violet")
y<-ggplot(percentages, aes(x=cover, y=August_28, color=cover)) + geom_bar(stat="identity", fill="yellow")
grid.arrange(v, y, ncol=2)


# metto in un unico grafico tutte le date posizionandolo in orizzontale
C1 <- ggplot(percentages, aes(x=cover, y=July_10, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C1 + coord_flip()
C2 <- ggplot(percentages, aes(x=cover, y=August_28, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C2 + coord_flip()

barsgraph <-grid.arrange(C1 + coord_flip(), C2 + coord_flip(), nrow=2)
ggsave("bars.jpg", barsgraph) 

# uso l funzione grid.arrange per mettere i grafici in una pagina  della gridextra già installato
circlegraph <- grid.arrange(C1 + coord_polar(theta = "x", direction=1 ), C2 + coord_polar(theta = "x", direction=1 )) 
         
ggsave("grid.arrange.jpg", circlegraph) 
# la funzione coord_polard mi permette di visualizzare il grafico in modo circolare e particolare
_________________________________________________________



#IMPORTO IMMAGINE 2019

# Importo i file tutti insieme (invece che singolarmente) utilizzando la funzione stack
# Funzione list.files: crea lista di file per la funzione lapply 


plist <- list.files(pattern="LC08")     # pattern = è la scritta in comune in ogni file

plist                                   # per ottenre le informazioni sui file 
      #[1] "LC08_L2SP_121040_20220811_20220818_02_T1_SR_B1.TIF" "LC08_L2SP_121040_20220811_20220818_02_T1_SR_B2.TIF"
      #[3] "LC08_L2SP_121040_20220811_20220818_02_T1_SR_B3.TIF" "LC08_L2SP_121040_20220811_20220818_02_T1_SR_B4.TIF"
      #[5] "LC08_L2SP_121040_20220811_20220818_02_T1_SR_B5.TIF" "LC08_L2SP_121040_20220811_20220818_02_T1_SR_B6.TIF"
      #[7] "LC08_L2SP_121040_20220811_20220818_02_T1_SR_B7.TIF"
      # Funzione lapply: applica alla lista dei file una funzione (raster) 
import <- lapply(plist,raster)

import
      # [[1]]
      # class      : RasterLayer 
      # dimensions : 7811, 7671, 59918181  (nrow, ncol, ncell)
      # resolution : 30, 30  (x, y)
      # extent     : 338085, 568215, 3075885, 3310215  (xmin, xmax, ymin, ymax)
      # crs        : +proj=utm +zone=50 +datum=WGS84 +units=m +no_defs 
      # source     : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B1.TIF 
      # names      : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B1 
      # values     : 0, 65535  (min, max)


      # [[2]]
      # class      : RasterLayer 
      # dimensions : 7811, 7671, 59918181  (nrow, ncol, ncell)
      # resolution : 30, 30  (x, y)
      # extent     : 338085, 568215, 3075885, 3310215  (xmin, xmax, ymin, ymax)
      # crs        : +proj=utm +zone=50 +datum=WGS84 +units=m +no_defs 
      # source     : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B2.TIF 
      # names      : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B2 
      # values     : 0, 65535  (min, max)


      # [[3]]
      # class      : RasterLayer 
      # dimensions : 7811, 7671, 59918181  (nrow, ncol, ncell)
      # resolution : 30, 30  (x, y)
      # extent     : 338085, 568215, 3075885, 3310215  (xmin, xmax, ymin, ymax)
      # crs        : +proj=utm +zone=50 +datum=WGS84 +units=m +no_defs 
      # source     : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B3.TIF 
      # names      : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B3 
      # values     : 0, 65535  (min, max)


      # # [[4]]
      # class      : RasterLayer 
      # dimensions : 7811, 7671, 59918181  (nrow, ncol, ncell)
      # resolution : 30, 30  (x, y)
      # extent     : 338085, 568215, 3075885, 3310215  (xmin, xmax, ymin, ymax)
      # crs        : +proj=utm +zone=50 +datum=WGS84 +units=m +no_defs 
      # source     : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B4.TIF 
      # names      : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B4 
      # values     : 0, 65535  (min, max)


      # [[5]]
      # class      : RasterLayer 
      # dimensions : 7811, 7671, 59918181  (nrow, ncol, ncell)
      # resolution : 30, 30  (x, y)
      # extent     : 338085, 568215, 3075885, 3310215  (xmin, xmax, ymin, ymax)
      # crs        : +proj=utm +zone=50 +datum=WGS84 +units=m +no_defs 
      # source     : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B5.TIF 
      # names      : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B5 
      # values     : 0, 65535  (min, max)


      # [[6]]
      # class      : RasterLayer 
      # dimensions : 7811, 7671, 59918181  (nrow, ncol, ncell)
      # resolution : 30, 30  (x, y)
      # extent     : 338085, 568215, 3075885, 3310215  (xmin, xmax, ymin, ymax)
      # crs        : +proj=utm +zone=50 +datum=WGS84 +units=m +no_defs 
      # source     : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B6.TIF 
      # names      : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B6 
      # values     : 0, 65535  (min, max)


      # [[7]]
      # class      : RasterLayer 
      # dimensions : 7811, 7671, 59918181  (nrow, ncol, ncell)
      # resolution : 30, 30  (x, y)
      # extent     : 338085, 568215, 3075885, 3310215  (xmin, xmax, ymin, ymax)
      # crs        : +proj=utm +zone=50 +datum=WGS84 +units=m +no_defs 
      # source     : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B7.TIF 
      # names      : LC08_L2SP_121040_20220811_20220818_02_T1_SR_B7 
      # values     : 0, 65535  (min, max)



# Funzione stack: raggruppa e rinomina, in un unico pacchetto, i file raster separati
poyang19<- stack(import)
# Funzione per avere le info sul file
poyang19
      #lass      : RasterStack 
      #dimensions : 7811, 7671, 59918181, 7  (nrow, ncol, ncell, nlayers)
      #resolution : 30, 30  (x, y)
      #extent     : 338085, 568215, 3075885, 3310215  (xmin, xmax, ymin, ymax)
      #crs        : +proj=utm +zone=50 +datum=WGS84 +units=m +no_defs 
      #names      : LC08_L2SP//2_T1_SR_B1, LC08_L2SP//2_T1_SR_B2, LC08_L2SP//2_T1_SR_B3, LC08_L2SP//2_T1_SR_B4, LC08_L2SP//2_T1_SR_B5, LC08_L2SP//2_T1_SR_B6, LC08_L2SP//2_T1_SR_B7 
      #min values :                     0,                     0,                     0,                     0,                     0,                     0,                     0 
      #max values :                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535 


# Funzione plotRGB: crea plot con immagini sovrapposte
plotRGB(poyang19, r=4, g=3, b=2, stretch="lin")
             
#Crop con drawExtent() ////////////////// Non lanciare si R
# after running the following line, click on the map twice
e <- drawExtent(show=TRUE, col="red")

# after running the following line, click on the map twice
cro<-crop(poyang19, e)
plotRGB(cro, r=1, g=2, b=3, stretch="lin")

#salva immagine 2019 true colors
jpeg("cro.jpg")
plotRGB(cro, r=3, g=2, b=1, stretch="lin")
dev.off()


#salvo e importo immagine 521
jpeg("cro521.jpg")
plotRGB(cro, r=5, g=2, b=1, stretch="lin")
dev.off()

#salvo e importo immagine 764
jpeg("cro764.jpg")
plotRGB(cro, r=7, g=6, b=4, stretch="lin")
dev.off()

#////////////////////////////////////////////////////

#Importo immagioni croppate
Poyang2019 <- brick("cro.jpg")
Poyang19_5 <- brick("cro521.jpg")
Poyang19_7 <- brick("cro764.jpg")

par(mfrow=c(2,2)) # plotto 2 colonne e 2 righe
plotRGB(poyangJ, r=1, g=2, b=3, stretch="lin")
plotRGB(poyangA, r=1, g=2, b=3, stretch="lin")
plotRGB(Poyang19_7, r=1, g=2, b=3, stretch="lin")
#____________________________________________________________________




# Spectral Indices

# La funzione spectralIndices permette di calcolare tutti gli indici
# b1=NIR, b2=rosso, b3=verde

#july
spPo1<- spectralIndices(poyangJ, swir1=1, nir=2, red=3) #colori associati al N° della banda
# Cambio i colori con colorRampPalette
cl <- colorRampPalette(c('purple','yellow','light pink','orange'))(100)
# Nuovo plot col cambio di colori
plot(spPo1, col=cl)

#august
spPo2 <- spectralIndices(poyangA, swir1=1, nir=2, red=3) #colori associati al N° della banda
# Nuovo plot col cambio di colori
plot(spPo2, col=cl)

# guardo come si chiamano le bande del NIR e del ROSSO. 
poyangJ
# poyang_oli_2022191_lrg.1, poyang_oli_2022191_lrg.2, poyang_oli_2022191_lrg.3 
poyangA
#poyang_oli_2022239_lrg.1,
poyang_oli_2022239_lrg.2, poyang_oli_2022239_lrg.3 

#1. DVI luglio NIR - RED
dvi1 <- poyangJ$poyang_oli_2022191_lrg.2 - poyangJ$poyang_oli_2022191_lrg.3
plot(dvi1)
cld <- colorRampPalette(c('yellow','purple','green','light blue'))(100)
plot(dvi1, col=cld, main="DVI of Poyang Lake in July")

dvi2 <- poyangA$poyang_oli_2022239_lrg.2 - poyangA$poyang_oli_2022239_lrg.3
plot(dvi2)
cld <- colorRampPalette(c('yellow','purple','green','light blue'))(100)
plot(dvi2, col=cld, main="DVI of Poyang Lake in August")

# Confronto il tutto per far emergere le differenze 
par(mfrow=c(1,2))
plot(dvi1, col=cld, main="DVI of Poyang Lake in July")
plot(dvi2, col=cld, main="DVI of Poyang Lake in August")

difdvi <- dvi1 - dvi2
cldd <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cldd)


# 2. NDVI - Normalized Difference Vegetation Index

# NDVI= (NIR-RED) / (NIR+RED)
# NDVI del Lago Poyang in July
ndvi1 <- (dvi1) / (poyangJ$poyang_oli_2022191_lrg.2 + poyangJ$poyang_oli_2022191_lrg.3)
plot(ndvi1, col=cld, main="NDVI of Poyang Lake in July")


# NDVI del Lago Poyang in August
ndvi2 <- (dvi2) / (poyangA$poyang_oli_2022239_lrg.2 + poyangA$poyang_oli_2022239_lrg.3)
plot(ndvi2, col=cld, main="NDVI of Poyang Lake in August")

par(mfrow=c(1,2))
plot(ndvi1, col=cld, main="NDVI of Poyang Lake in July")
plot(ndvi2, col=cld, main="NDVI of Poyang Lake in August")

# Differenza del NDVI
difndvi <- ndvi1 - ndvi2
plot(difndvi, col=cldd)



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
library (rasterdiv)                            # per calcolare indici di diversità e matrici numeriche 

# Settaggio della working directory 
setwd("/Users/ilari/Desktop/lab/Esame/")

#Importazione immagini
poyangJ <- brick("poyang_oli_2022191_lrg.jpg") # July
poyangA <- brick("poyang_oli_2022239_lrg.jpg")# August

#Plottaggio 2 immagini colori naturali
par(mfrow=c(1,2))
plotRGB(poyangJ, r=1, g=2, b=3, stretch="lin")
plotRGB(poyangA, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
plotRGB(poyangJ, r=3, g=2, b=1, stretch="hist")
plotRGB(poyangA, r=3, g=2, b=1, stretch="hist")

#salvo per latex//////
jpeg("plo1.jpg")
plotRGB(poyangJ, r=3, g=2, b=1, stretch="hist")
dev.off()

jpeg("plo2.jpg")
plotRGB(poyangA, r=3, g=2, b=1, stretch="hist")
dev.off()
///////////////////////////////////////////////

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
par(mfrow=c(1,2)) # 2 colonne e 2 righe
plotRGB(PJulyc, r=1, g=2, b=3, stretch="lin")
plotRGB(PAuguc, r=1, g=2, b=3, stretch="lin")


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


___________________________________________________________________________________________________________
#effettuiamo una categorizzazione in 6 classi di colore per distinguere le zone con ghiaccio, con acqua e "altro"
set.seed(42)

ClP3 <- unsuperClass(Poyang19_7, nClasses=6)  
colo <- colorRampPalette(c('yellow','orange','red','green','blue','purple'))(100) 

# metto le immagini insieme per avere una mappa della situazione 
plot(ClP3$map, col=colo)





                                         ------------------------
# MULTIVARIATE ANALYSIS
??????????????????????????????????????????????????????????????
# 1. Le coppie di funzioni producono una matrice di scatterplot.

# Traccia le correlazioni tra le 3 bande del mio stack.
# I valori di correlazione degli indici vanno da 0 a 1: 1= correlazione, 0 = nessuna correlazione
# Plot di tutte le correlazioni tra bande di un dataset (matrice di scatterplot di dati, non immagini)
# La tabella riporta in diagonale le bande (sono le variabili)
pairs(P2019, main="Comparation with the function pairs")


P2019_pca <- rasterPCA(P2019)#????????

summary(P2019_pca$model)

# dev.off()
plotRGB(P2019s_pca$map, r=1, g=2, b=3, stretch="lin")

# Indice di correlazione: più le bande sono correlate e maggiore sarà la dimensione dei caratteri

# Importazione delle singole immagini per effettuare comparazioni
# Funzione: brick, importa i singoli file per avere dati e immagini a 3 bande
# Non utilizzo la funzione raster perchè successivamente farò l'analisi della PCA nella quale servono almeno 2 bande 

poyangJ <- brick("poyang_oli_2022191_lrg.jpg") # July
poyangA <- brick("poyang_oli_2022239_lrg.jpg")# August

par(mfrow=c(1,2))
plotRGB(poyangJ, r=1, g=2, b=3, stretch="lin")
plotRGB(poyangA, r=1, g=2, b=3, stretch="lin")
?????????????????????????????????????????????????????????????????????????


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

                                                            ------------------------ 
# 2. Analisi delle componenti principali

# PCA July
poyang1_pca <-rasterPCA(poyangJ) #?????????????
summary(poyang1_pca$model)
# Importance of components:
#                           Comp.1     Comp.2      Comp.3
#Standard deviation     85.3441855 32.9645973 18.52486015
#Proportion of Variance  0.8359051  0.1247110  0.03938392
#Cumulative Proportion   0.8359051  0.9606161  1.00000000

plotRGB(poyang1_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(poyang1_pca$model) # per vedere il grafico

#PCA August
poyang2_pca <- rasterPCA(poyangA)
summary(poyang2_pca$model)
# Importance of components:
#                             Comp.1     Comp.2      Comp.3
# Standard deviation     109.2553346 59.9319584 27.67877126
# Proportion of Variance   0.7325536  0.2204302  0.04701622
# Cumulative Proportion    0.7325536  0.9529838  1.00000000

plotRGB(poyang2_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(poyang2_pca$model) # per vedere il grafico

# confrontiamo le PCA ottenute in Luglio e Agosto
levelplot(An12,col.regions=cls, main="Water level drop", names.attr=c("July","August"))


par(mfrow=c(1,2)) # 3 colonne e 2 righe
plotRGB(andes1_pca$map,r=1,g=2,b=3, stretch="Hist") 
plotRGB(andes2_pca$map,r=1,g=2,b=3, stretch="Hist") 

                                                           --------------------
# Multiframe con ggplot
PoJuly <- ggRGB(poyang1_pca$map,r=1,g=2,b=3, stretch="Hist")        
PoAugu <- ggRGB(poyang2_pca$map,r=1,g=2,b=3, stretch="Hist")
grid.arrange(PoJuly, PoAugu, nrow=1, top = textGrob("Water level drop between July 2022  and August 2022",gp=gpar(fontsize=25,font=4)))

C <- grid.arrange(Co1986, Co1995, nrow=1, top = textGrob("Water level drop between July 2022  and August 2022",gp=gpar(fontsize=25,font=4)))

ggsave("grid.arrange.jpg",C) 

                                                              -----------------------
 

#.....................................................................................................................................

# FIRME SPETTRALI

# Creo una firma spettrale dell'immagine Columbia 1986 con la funzione "click"
plotRGB(poyangJ, r=1, g=2, b=3, stretch="lin")
click(poyangJ, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#         x      y     cell poyang_oli_2022191_lrg.1 poyang_oli_2022191_lrg.2 poyang_oli_2022191_lrg.3
#1 1686.5 3297.5 10489162                        0                       25                       48
#       x      y     cell poyang_oli_2022191_lrg.1 poyang_oli_2022191_lrg.2 poyang_oli_2022191_lrg.3
#1 2087.5 1272.5 20977038                       93                      171                       52
#       x      y    cell poyang_oli_2022191_lrg.1 poyang_oli_2022191_lrg.2 poyang_oli_2022191_lrg.3
#1 2648.5 3770.5 8040457                        0                       40                       75


# Creo una firma spettrale dell'immagine Columbia 2019 con la funzione "click"
plotRGB(poyangA, r=1, g=2, b=3, stretch="lin")
# Bisogna avere la mappa fatta con plotRGB aperta sotto
# Utilizzo la funzione click per cliccare sull'immagine plotRGB e le firme spettrali 
click(poyangA, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

# x      y     cell poyang_oli_2022239_lrg.1 poyang_oli_2022239_lrg.2 poyang_oli_2022239_lrg.3
#1 1772.5 3368.5 10121539                      207                      203                      158
#      x      y     cell poyang_oli_2022239_lrg.1 poyang_oli_2022239_lrg.2 poyang_oli_2022239_lrg.3
#1 2043.5 1301.5 20826803                      149                      172                       55
#      x      y    cell poyang_oli_2022239_lrg.1 poyang_oli_2022239_lrg.2 poyang_oli_2022239_lrg.3
#1 2388.5 3705.5 8376832                        0                      175                      162

# Creo ora un set di dati con i nostri risultati, definendo le colonne del dataset
band <- c(1,2,3)
Poyang1p1 <- c(0, 25, 48)
Poyang1p2 <- c(93, 171, 52)
Poyang1p3 <- c(0, 40, 75)
Poyang2p1 <- c(207, 203, 158)
Poyang2p2 <- c(149, 172, 55)
Poyang2p3 <- c(0, 175, 162)

# Funzione data.frame: crea un dataframe (tabella)
spectralP <- data.frame(band,Poyang1p1,Poyang1p2,Poyang1p3,Poyang2p1,Poyang2p2,Poyang2p3)
# richiamo spectralst per avere le info sul file
spectralP

# band Poyang1p1 Poyang1p2 Poyang1p3 Poyang2p1 Poyang2p2 Poyang2p3
# 1    1         0        93         0       207       149         0
# 2    2        25       171        40       203       172       175
# 3    3        48        52        75       158        55       162




# Plot delle firme spettrali
# Utilizzo la funzione ggplot per determinare l'estetica del grafico
# Rosso per i risultati di July, blu per i risultati di August
# Funzione geom_line: connette le osservazioni a seconda del dato che è sulla X/Y
# Funzione labs: modifica le etichette degli assi, le legende e il plottaggio
ggplot(spectralP, aes(x=band)) +
geom_line(aes(y = Poyang1p1), color="blue") +
geom_line(aes(y = Poyang1p2), color="blue") +
geom_line(aes(y = Poyang1p3), color="blue") +
geom_line(aes(y = Poyang2p1), color="red") +
geom_line(aes(y = Poyang2p2), color="red") +
geom_line(aes(y = Poyang2p3), color="red") +
labs(x="band", y="reflectance")


# Traccio questo set di dati con altri colori e linee evidenziando i punti fondamentali
# Ilcolore chiaro e linea non continua rappresenta i risultati del 1986, il colore scuro pieno rappresenta i risultati del 2019
ggplot(spectralP, aes(x=band)) +
geom_line(aes(y = Poyang1p1), linetype="dotdash", color="light blue", size=2)+ geom_point(aes(y = Poyang1p1), color="light blue", size=3) + 
geom_line(aes(y = Poyang1p2), linetype="dotdash", color="pink", size=2) + geom_point(aes(y = Poyang1p2), color="pink", size=3) + 
geom_line(aes(y = Poyang1p3), linetype="dotdash", color="yellow", size=2) + geom_point(aes(y = Poyang1p3), color="yellow", size=3) + 
geom_line(aes(y = Poyang2p1), color="orange", size=2) + geom_point(aes(y = Poyang2p1), color="orange", size=3) + 
geom_line(aes(y = Poyang2p2), color="blue", size=2) + geom_point(aes(y = Poyang2p2), color="blue", size=3) + 
geom_line(aes(y = Poyang2p3), color="purple", size=2) + geom_point(aes(y = Poyang2p3), color="purple", size=3) + 
labs(x="band", y="reflectance") 

#la funzione linetype mi permette di tratteggiare le linee
# geom_poit mi evidenzia i punti di flesso
#questo procedimento normalmente si fa con moltissimi pixel. si usa una funzione per la generazione dei punti random e poi un'altra per estrarre da tutti i valori delle bande


#------------------------------------------------------------------------------------------------------------------------------------------------


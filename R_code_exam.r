 # In summer 2022, an early season heatwave caused many glaciers in the central Andes to lose their snow unusually early. 
 # Temperatures soared to 40°C (104°F) in January 2022, rapidly melting off snowpack on several glaciers and exposing darker, dirtier ice.
 #  https://earthobservatory.nasa.gov/images/149969/losing-a-layer-of-protection
 # Earth explorer - Landsaat 8 - OLI
 



# caricamento delle library necessarie al funzionamento dei codici seguenti:
library(raster)  # permette l'utilizzo dei raster e funzioni annesse
library(rasterVis) # mi permette di visualizzare matrici e fornisce metodi di visualizzazione per i dati raster --> con questa libreria posso utilizzare la funzione levelplot
library(RStoolbox) # permette l'uso della Unsupervised Classification
library(ggplot2)  # permette l'uso delle funzioni ggplot
library(gridExtra)   # permette l'uso e creazione di griglie, tabelle e grafici
library(rgdal) # per le firme spettrali
library(grid) # Il pacchetto grid in R implementa le funzioni grafiche primitive che sono alla base del sistema di plottaggio ggplot2
library (rasterdiv)

# settaggio della working directory 
setwd("/Users/ilari/Desktop/lab/Esame/")

andes1 <- brick("andes_oli_20213321_lrg.jpg") # November 28
andes2 <- brick("andes_oli_20220151_lrg.jpg")# January 15

ext1 <- c(1500, 30000, -2000, 2500) # coordinate (long ovest, long est, lat sud, lat nord)
ext2 <- c(1500, 30000, -2000, 2500) # coordinate (long ovest, long est, lat sud, lat nord)

extension1 <- crop(andes1, ext1)
extension2 <- crop(andes2, ext2)

par(mfrow=c(1,2))
plotRGB(extension1, r=1, g=2, b=3, stretch="lin")
plotRGB(extension2, r=1, g=2, b=3, stretch="lin")


b1<- raster("LC08_L2SP_233084_20220115_20220123_02_T1_SR_B1.TIF")
b2<- raster("LC08_L2SP_233084_20220115_20220123_02_T1_SR_B2.TIF")
b3<- raster("LC08_L2SP_233084_20220115_20220123_02_T1_SR_B3.TIF")
b4<- raster("LC08_L2SP_233084_20220115_20220123_02_T1_SR_B4.TIF")
b5<- raster("LC08_L2SP_233084_20220115_20220123_02_T1_SR_B5.TIF")
b6<- raster("LC08_L2SP_233084_20220115_20220123_02_T1_SR_B6.TIF")
b7<- raster("LC08_L2SP_233084_20220115_20220123_02_T1_SR_B7.TIF")
list1 <- list(b1, b2, b3, b4, b5, b6, b7)
sta <- stack (list1)
sta
plot(sta)

plotRGB(sta, r=1, g=2, b=3, stretch="lin")

# after running the following line, click on the map twice
e <- drawExtent()
# after running the following line, click on the map twice
cro<-mean(values(crop(sta, drawExtent())))
plotRGB(cro, r=1, g=2, b=3, stretch="lin")


par(mfrow=c(1,2))
plotRGB(andes1, r=1, g=2, b=3, stretch="lin")
plotRGB(andes2, r=1, g=2, b=3, stretch="lin")



# Importo i file tutti insieme (invece che singolarmente) utilizzando la funzione stack
# Funzione list.files: crea lista di file per la funzione lapply 

clist <- list.files(pattern="andes") # pattern = è la scritta in comune in ogni file, nel mio caso è columbia 
# per ottenre le informazioni sui file 
clist
# [1] "andes_oli_20213321_lrg.jpg" "andes_oli_20220151_lrg.jpg"

# Funzione lapply: applica alla lista dei file una funzione (raster) 
import <- lapply(clist,raster)
# per ottenre le informazioni sui file
import
#[[1]]
#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 3790, 3790, 14364100  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 3790, 0, 3790  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : andes_oli_20213321_lrg.jpg 
#names      : andes_oli_20213321_lrg 
#values     : 0, 255  (min, max)


#[[2]]
#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 3790, 3790, 14364100  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 3790, 0, 3790  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : andes_oli_20220151_lrg.jpg 
#names      : andes_oli_20220151_lrg 
#values     : 0, 255  (min, max)

# Funzione stack: raggruppa e rinomina, in un unico pacchetto, i file raster separati
An12<- stack(import)
# Funzione per avere le info sul file
An12

#class      : RasterStack 
#dimensions : 3790, 3790, 14364100, 2  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 3790, 0, 3790  (xmin, xmax, ymin, ymax)
#crs        : NA 
#names      : andes_oli_20213321_lrg, andes_oli_20220151_lrg 
#min values :                     0,                     0 
#max values :                   255,                   255 


# Funzione plot: del singolo file
plot(An12)
# Funzione plotRGB: crea plot con immagini sovrapposte
plotRGB(An12, r=3, g=2, b=1, stretch="hist")
# Funzione ggr: plotta file raster in differenti scale di grigio, migliorando la qualità dell'immagine e aggiungengo le coordinate spaziali sugli assi x e y
ggRGB(An12, r=3, g=2, b=1, stretch="hist") # "hist": amplia i valori e aumenta i dettagli


# Funzione levelplot: disegna più grafici di colore falso con una singola legenda
levelplot(An12)
# Cambio di colori a piacimento (colorRampPalette si può usare solo su immagine singole, non su RGB)
cls<-colorRampPalette(c("red","blue","yellow","white"))(100)
# Nuovo levelplot col cambio di colori, nome e titolo
levelplot(An12,col.regions=cls, main="Variation ice cover in time", names.attr=c("Nov","Jan"))
---------

# MULTIVARIATE ANALYSIS

# 1. Le coppie di funzioni producono una matrice di scatterplot.

# Traccia le correlazioni tra le 3 bande del mio stack.
# I valori di correlazione degli indici vanno da 0 a 1: 1= correlazione, 0 = nessuna correlazione
# Plot di tutte le correlazioni tra bande di un dataset (matrice di scatterplot di dati, non immagini)
# La tabella riporta in diagonale le bande (sono le variabili)
pairs(An12, main="Comparation with the function pairs")
# Result= 0.81
# Indice di correlazione: più le bande sono correlate e maggiore sarà la dimensione dei caratteri

# Importazione delle singole immagini per effettuare comparazioni
# Funzione: brick, importa i singoli file per avere dati e immagini a 3 bande
# Non utilizzo la funzione raster perchè successivamente farò l'analisi della PCA nella quale servono almeno 2 bande 
andes1 <- brick("andes_oli_20213321_lrg.jpg") # November 28
andes2 <- brick("andes_oli_20220151_lrg.jpg")# January 15

par(mfrow=c(1,2))
plotRGB(andes1, r=1, g=2, b=3, stretch="lin")
plotRGB(andes2, r=1, g=2, b=3, stretch="lin")



# ora applichiamo l'algebra applicata alle matrici 
#utilizzo raster perchè non mi interessa ad avere le 3 bande divise ma una immagine con un'unica banda 
Andes1 <- raster("andes_oli_20213321_lrg.jpg") # November 28
Andes2 <- raster("andes_oli_20220151_lrg.jpg")# January 15

#vogliamo fare la sottrazione tra il primo e l'ultimo dato 
# $ il dollaro mi lega il file originale al file interno 
Andesice <- Andes2 - Andes1
# creo una nuova colour and palette 
clb <- colorRampPalette(c("red","white","yellow"))(100)
plot(Andesice, col=clb) # zone rosse dove c'è stato uno scioglimento dei ghiacci 
# usiamo level per avere una gamma di colori più dettagliata 
levelplot(Andesice, col.regions=clb, main="Scioglimento del ghiaccio dal 1986 al 2019")

# 2. Analisi delle componenti principali

# PCA del ghiacciaio Columbia 1986
andes1_pca <- rasterPCA(andes1)
summary(andes1_pca$model)
# Importance of components:
#                             Comp.1     Comp.2      Comp.3
# Standard deviation     109.2553346 59.9319584 27.67877126
# Proportion of Variance   0.7325536  0.2204302  0.04701622
# Cumulative Proportion    0.7325536  0.9529838  1.00000000

plotRGB(andes1_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(andes1_pca$model) # per vedere il grafico

andes2_pca <- rasterPCA(andes2)
summary(andes2_pca$model)
# Importance of components:
#                             Comp.1     Comp.2      Comp.3
# Standard deviation     109.2553346 59.9319584 27.67877126
# Proportion of Variance   0.7325536  0.2204302  0.04701622
# Cumulative Proportion    0.7325536  0.9529838  1.00000000

plotRGB(andes2_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(andes2_pca$model) # per vedere il grafico

# confrontiamo le PCA ottenute dal 1986 al 2019
levelplot(An12,col.regions=cls, main="Variazione della copertura di ghiaccio nel tempo", names.attr=c("1986","1995"))


par(mfrow=c(1,2)) # 3 colonne e 2 righe
plotRGB(andes1_pca$map,r=1,g=2,b=3, stretch="Hist") 
plotRGB(andes2_pca$map,r=1,g=2,b=3, stretch="Hist") 


# Multiframe con ggplot
Co1986 <- ggRGB(andes1_pca$map,r=1,g=2,b=3, stretch="Hist")        
Co1995 <- ggRGB(andes2_pca$map,r=1,g=2,b=3, stretch="Hist")
grid.arrange(Co1986, Co1995, nrow=1, top = textGrob("Ghiacciaio Columbia 1986-2019",gp=gpar(fontsize=25,font=4)))

C <- grid.arrange(Co1986, Co1995, nrow=1, top = textGrob("Ghiacciaio Columbia 1986-2019",gp=gpar(fontsize=25,font=4)))

ggsave("grid.arrange.jpg",C) 


# Spectral Indices

# La funzione spectralIndices permette di calcolare tutti gli indici
# b1=NIR, b2=rosso, b3=verde
# Immagine del ghiacciaio Columbia in Alaska nel 1986 
spAn1<- spectralIndices(andes1, green = 3, red = 2, nir = 1) #colori associati al N° della banda
# Cambio i colori con colorRampPalette
cl <- colorRampPalette(c('purple','yellow','light pink','orange'))(100)
# Nuovo plot col cambio di colori
plot(spAn1, col=cl)

# Immagine del ghiacciaio Columbia in Alaska nel 1995 
spAn2 <- spectralIndices(andes2, green = 3, red = 2, nir = 1) #colori associati al N° della banda
# Nuovo plot col cambio di colori
plot(spAn2, col=cl)

# guardo come si chiamano le bande del NIR e del ROSSO. 
andes1
# andes_oli_20213321_lrg.1, andes_oli_20213321_lrg.2, andes_oli_20213321_lrg.3 
andes2
#andes_oli_20220151_lrg.1, andes_oli_20220151_lrg.2, andes_oli_20220151_lrg.3 

# Primo indice del ghiacciaio Columbia in Alaska nel 1986: NIR - RED
dvi1 <- andes1$andes_oli_20213321_lrg.1 - andes1$andes_oli_20213321_lrg.2
plot(dvi1)
cld <- colorRampPalette(c('yellow','purple','green','light blue'))(100)
plot(dvi1, col=cld, main="DVI of Columbia 1986")

dvi2 <- andes2$andes_oli_20220151_lrg.1 - andes2$andes_oli_20220151_lrg.2
plot(dvi2)
cld <- colorRampPalette(c('yellow','purple','green','light blue'))(100)
plot(dvi2, col=cld, main="DVI of Columbia 1986")

# Confronto il tutto per far emergere le differenze 
par(mfrow=c(1,2))
plot(dvi1, col=cld, main="DVI of Columbia 1986")
plot(dvi2, col=cld, main="DVI of Columbia 1995")

difdvi <- dvi1 - dvi2
cldd <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cldd)


# 2. NDVI - Normalized Difference Vegetation Index

# NDVI= (NIR-RED) / (NIR+RED)
# NDVI del ghiacciaio Columbia in Alaska nel 1986
ndvi1 <- (dvi1) / (andes1$andes_oli_20213321_lrg.1 + andes1$andes_oli_20213321_lrg.2)
plot(ndvi1, col=cld, main="NDVI of Columbia 1986")


# NDVI del ghiacciaio Columbia in Alaska nel 1995
ndvi2 <- (dvi2) / (andes2$andes_oli_20220151_lrg.1 + andes2$andes_oli_20220151_lrg.2)
plot(ndvi2, col=cld, main="NDVI of Columbia 1995")

par(mfrow=c(1,2))
plot(ndvi1, col=cld, main="NDVI of Columbia 1986")
plot(ndvi2, col=cld, main="NDVI of Columbia 1995")

# Differenza del NDVI
difndvi <- ndvi1 - ndvi2
plot(difndvi, col=cldd)

#.....................................................................................................................................

# FIRME SPETTRALI

# Creo una firma spettrale dell'immagine Columbia 1986 con la funzione "click"
plotRGB(andes1, r=1, g=2, b=3, stretch="lin")
click(andes1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#      x      y    cell andes_oli_20213321_lrg.1 andes_oli_20213321_lrg.2 andes_oli_20213321_lrg.3
#1 3231.5 1312.5 9391062                      240                      239                      235
#       x      y    cell andes_oli_20213321_lrg.1 andes_oli_20213321_lrg.2 andes_oli_20213321_lrg.3
#1 2796.5 1454.5 8852447                      255                      224                      255
#       x      y    cell andes_oli_20213321_lrg.1 andes_oli_20213321_lrg.2 andes_oli_20213321_lrg.3
#1 1429.5 2309.5 5610630                       30                       43                       23
# Creo una firma spettrale dell'immagine Columbia 2019 con la funzione "click"
plotRGB(andes2, r=1, g=2, b=3, stretch="lin")
# Bisogna avere la mappa fatta con plotRGB aperta sotto
# Utilizzo la funzione click per cliccare sull'immagine plotRGB e le firme spettrali 
click(andes2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

# x      y    cell andes_oli_20220151_lrg.1 andes_oli_20220151_lrg.2 andes_oli_20220151_lrg.3
#1 3243.5 1356.5 9224314                      219                      215                      206
#       x      y    cell andes_oli_20220151_lrg.1 andes_oli_20220151_lrg.2 andes_oli_20220151_lrg.3
#1 2827.5 1456.5 8844898                      125                       96                       78
#       x      y    cell andes_oli_20220151_lrg.1 andes_oli_20220151_lrg.2 andes_oli_20220151_lrg.3
#1 1415.5 2299.5 5648516                         56                       58                       44

# Creo ora un set di dati con i nostri risultati, definendo le colonne del dataset
band <- c(1,2,3)
Andes1p1 <- c(240, 239, 235)
Andes1p2 <- c(255, 224, 255)
Andes1p3 <- c(30, 43, 23)
Andes2p1 <- c(219, 215, 206)
Andes2p2 <- c(125, 96, 78)
Andes2p3 <- c(56, 58, 44)

# Funzione data.frame: crea un dataframe (tabella)
spectralCo <- data.frame(band,Andes1p1,Andes1p2,Andes1p3,Andes2p1,Andes2p2,Andes2p3)
# richiamo spectralst per avere le info sul file
spectralCo

band Andes1p1 Andes1p2 Andes1p3 Andes2p1 Andes2p2 Andes2p3
1    1      240      255       30      219      125       56
2    2      239      224       43      215       96       58
3    3      235      255       23      206       78       44


# Plot delle firme spettrali
# Utilizzo la funzione ggplot per determinare l'estetica del grafico
# Rosso per i risultati del 2019, blu per i risultati del 2021
# Funzione geom_line: connette le osservazioni a seconda del dato che è sulla X/Y
# Funzione labs: modifica le etichette degli assi, le legende e il plottaggio
ggplot(spectralCo, aes(x=band)) +
geom_line(aes(y = Andes1p1), color="blue") +
geom_line(aes(y = Andes1p2), color="blue") +
geom_line(aes(y = Andes1p3), color="blue") +
geom_line(aes(y = Andes2p1), color="red") +
geom_line(aes(y = Andes2p2), color="red") +
geom_line(aes(y = Andes2p3), color="red") +
labs(x="band", y="reflectance")


# Traccio questo set di dati con altri colori e linee evidenziando i punti fondamentali
# Ilcolore chiaro e linea non continua rappresenta i risultati del 1986, il colore scuro pieno rappresenta i risultati del 2019
ggplot(spectralCo, aes(x=band)) +
geom_line(aes(y = Andes1p1), linetype="dotdash", color="light blue", size=2)+ geom_point(aes(y = Andes1p1), color="light blue", size=3) + 
geom_line(aes(y = Andes1p2), linetype="dotdash", color="pink", size=2) + geom_point(aes(y = Andes1p2), color="pink", size=3) + 
geom_line(aes(y = Andes1p3), linetype="dotdash", color="yellow", size=2) + geom_point(aes(y = Andes1p3), color="yellow", size=3) + 
geom_line(aes(y = Andes2p1), color="orange", size=2) + geom_point(aes(y = Andes2p1), color="orange", size=3) + 
geom_line(aes(y = Andes2p2), color="blue", size=2) + geom_point(aes(y = Andes2p2), color="blue", size=3) + 
geom_line(aes(y = Andes2p3), color="purple", size=2) + geom_point(aes(y = Andes2p3), color="purple", size=3) + 
labs(x="band", y="reflectance") 

#la funzione linetype mi permette di tratteggiare le linee
# geom_poit mi evidenzia i punti di flesso
#questo procedimento normalmente si fa con moltissimi pixel. si usa una funzione per la generazione dei punti random e poi un'altra per estrarre da tutti i valori delle bande


#------------------------------------------------------------------------------------------------------------------------------------------------

# unsupervised classification
#si chiama così perchè è il software che scegli random un campione di pixel nell'immagine da dividere in classi

set.seed(42)
#la divisioni in classi è random, nel senso che, anche se il numero è sempre 4, 
#una volta la classe 1 è la foresta e la classe 2 la parte agricola ma se chiudo R e rifaccio questa operazione si possono invertire.
#per evitare questa cosa esiste la funzione set.seed() che ci permette di assegnare un numero al risultato 
#(nel nostro caso la suddivisione in classi) della funzione così che non cambi mai.

#effettuiamo una categorizzazione in 4 classi di colore per distinguere le zone con ghiaccio, con acqua e "altro"
ClAn1 <- unsuperClass(andes1, nClasses=5)  
ClAn2 <- unsuperClass(andes2, nClasses=5)  

# metto le immagini insieme per avere una mappa della situazione 
par(mfrow=c(1,2)) # 3 colonne e 2 righe
plot(ClAn1$map)
plot(ClAn2$map)

#ora proviamo a calcolare la frequenza dei pixel di una certa classe.
#lo possiamo fare con la funzion freq 

set.seed(42)
plot(ClAn1$map)
freq(ClAn1$map)  # freq è la funzione che mi va a calcolare la frequenza 
#      value  count
# value   count
#[1,]     1 3807178
#[2,]     2  570689
#[3,]     3 3850156
#[4,]     4 1628603
#[5,]     5 4507474

set.seed(42)
plot(ClAn2$map)
freq(ClAn2$map)  
  value   count
#[1,]     1  891962
#[2,]     2 3906712
#[3,]     3 3759189
#[4,]     4 3125065
#[5,]     5 2681172


# ora calcoliamo la proporzione 
#facciamo la somma dei valori 
s1 <- 3807178 + 570689 + 3850156 + 1628603 + 4507474
s1 # [1] 14364100, questo valore deve essere uguale per tutti 

s2 <- 891962 + 3906712 + 3759189 + 3125065 + 2681172
s2 #[1] 14364100

#per calcolare la proporzione facciamo la frequenza fratto il totale
prop1 <- freq(ClAn1$map)/ s1
prop1
#value      count
#[1,] 6.961801e-08 0.26504814
#[2,] 1.392360e-07 0.03973023
#[3,] 2.088540e-07 0.26804018
#[4,] 2.784720e-07 0.11338009
#[5,] 3.480900e-07 0.31380135
> 
prop2 <- freq(ClAn2$map) / s2
prop2

 #value      count
#[1,] 6.961801e-08 0.06209662
#[2,] 1.392360e-07 0.27197750
#[3,] 2.088540e-07 0.26170724
#[4,] 2.784720e-07 0.21756079
#[5,] 3.480900e-07 0.18665785


cover <- c("ghiaccio + neve ", "acqua", "vegetazione + nuvole")
percent_1986 <- c(45.07, 27.07, 27.87)
percent_1995 <- c(40.97, 27.92, 31.08)

# per crare il nostro data Frames uso la funzione data.frame
percentages <- data.frame(cover, percent_1986, percent_1995)
percentages

ggplot(percentages, aes(x=cover, y=percent_1986, color=cover)) + geom_bar(stat="identity", fill="violet")
ggplot(percentages, aes(x=cover, y=percent_1995, color=cover)) + geom_bar(stat="identity", fill="yellow")

# metto in un unico grafico tutte le date posizionandolo in orizzontale
C1 <- ggplot(percentages, aes(x=cover, y=percent_1986, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C1 + coord_flip()
C2 <- ggplot(percentages, aes(x=cover, y=percent_1995, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C2 + coord_flip()

grid.arrange(C1 + coord_flip(), C2 + coord_flip(), nrow=2)

# uso l funzione grid.arrange per mettere i grafici in una pagina  della gridextra già installato
grid.arrange(C1 + coord_polar(theta = "x", direction=1 ), C2 + coord_polar(theta = "x", direction=1 )) 
         

# la funzione coord_polard mi permette di visualizzare il grafico in modo circolare e particolare


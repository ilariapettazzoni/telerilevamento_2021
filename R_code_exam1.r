                                                                        #Poyang Lake
                                                                   ------------------------
#Poyang Lake, in China’s Jiangxi Province, routinely fluctuates in size between the winter and summer seasons. 
#In winter, water levels on the lake in are typically low. Then, summer rains cause the country’s largest freshwater lake to swell as water flows in from the Yangtze River.
#The lake has not swelled in the summer of 2022. 
#A prolonged heat wave and drought across much of the Yangtze River Basin dried the lake out early and pushed water levels to lows not seen in decades.

#The Operational Land Imager (OLI) on Landsat 8 acquired these pairs of images on July 10, 2022 (left images), and August 27, 2022 (right images). 
#The images are composites, and combine OLI observations of shortwave infrared, near infrared, and visible light.

                                                                   ------------------------

# Caricamento delle library necessarie al funzionamento dei codici :
library(raster)         # permette l'utilizzo dei raster e funzioni annesse
library(rasterVis)      # permette di visualizzare matrici e fornisce metodi di visualizzazione per i dati raster --> con questa libreria posso utilizzare la funzione levelplot
library(RStoolbox)      # permette l'uso della Unsupervised Classification
library(ggplot2)        # permette l'uso delle funzioni ggplot
library(gridExtra)      # permette l'uso e creazione di griglie, tabelle e grafici
library(rgdal)          # per le firme spettrali
library(grid)           # Il pacchetto grid in R implementa le funzioni grafiche primitive che sono alla base del sistema di plottaggio ggplot2
library (rasterdiv)

# Settaggio della working directory 
setwd("/Users/ilari/Desktop/lab/Esame/")

#Importazione immagin
poyangJ <- brick("poyang_oli_2022191_lrg.jpg") # July
poyangA <- brick("poyang_oli_2022239_lrg.jpg")# August

#Plottaggio 2 immagini colori naturali
par(mfrow=c(1,2))
plotRGB(poyangJ, r=1, g=2, b=3, stretch="lin")
plotRGB(poyangA, r=1, g=2, b=3, stretch="lin")

#Crop immagini per maggior dettaglio
ext1 <- c(600, 3000, 2000, 20000) # coordinate (long ovest, long est, lat sud, lat nord)
ext2 <- c(600, 3000, 2000, 20000) # coordinate (long ovest, long est, lat sud, lat nord)

pj <- crop(poyangJ, ext1)
pa <- crop(poyangA, ext2)

par(mfrow=c(1,2))
plotRGB(pj, r=1, g=2, b=3, stretch="lin")
plotRGB(pa, r=1, g=2, b=3, stretch="lin")



# Importo i file tutti insieme (invece che singolarmente) utilizzando la funzione stack
# Funzione list.files: crea lista di file per la funzione lapply 

plist <- list.files(pattern="poyang") # pattern = è la scritta in comune in ogni file, nel mio caso è columbia 
# per ottenre le informazioni sui file 
plist
# [1] "poyang_oli_2022191_lrg.jpg" "poyang_oli_2022239_lrg.jpg"

# Funzione lapply: applica alla lista dei file una funzione (raster) 
import <- lapply(plist,raster)
# per ottenre le informazioni sui file
import

# [[1]]
# class      : RasterLayer 
# band       : 1  (of  3  bands)
# dimensions : 5323, 5179, 27567817  (nrow, ncol, ncell)
# resolution : 1, 1  (x, y)
# extent     : 0, 5179, 0, 5323  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : poyang_oli_2022191_lrg.jpg 
# names      : poyang_oli_2022191_lrg 
# values     : 0, 255  (min, max)


# [[2]]
# class      : RasterLayer 
# band       : 1  (of  3  bands)
# dimensions : 5323, 5179, 27567817  (nrow, ncol, ncell)
# resolution : 1, 1  (x, y)
# extent     : 0, 5179, 0, 5323  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : poyang_oli_2022239_lrg.jpg 
# names      : poyang_oli_2022239_lrg 
# values     : 0, 255  (min, max)



# Funzione stack: raggruppa e rinomina, in un unico pacchetto, i file raster separati
PoJA<- stack(import)
# Funzione per avere le info sul file
PoJA

#class      : RasterStack 
#dimensions : 5323, 5179, 27567817, 2  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 5179, 0, 5323  (xmin, xmax, ymin, ymax)
#crs        : NA 
#names      : poyang_oli_2022191_lrg, poyang_oli_2022239_lrg 
#min values :                      0,                      0 
#max values :                    255,                    255 


# Funzione plot: del singolo file
plot(PoJA)
# Funzione plotRGB: crea plot con immagini sovrapposte
#???????????????????

par(mfrow=c(1,2))
plotRGB(poyangJ, r=3, g=2, b=1, stretch="hist")
plotRGB(poyangA, r=3, g=2, b=1, stretch="hist")

# Funzione ggr: plotta file raster in differenti scale di grigio, migliorando la qualità dell'immagine e aggiungengo le coordinate spaziali sugli assi x e y
)
ggRGB(poyangJ, r=3, g=2, b=1, stretch="hist") # "hist": amplia i valori e aumenta i dettagli
ggRGB(poyangA, r=3, g=2, b=1, stretch="hist")

# Funzione levelplot: disegna più grafici di colore falso con una singola legenda ???????
levelplot(PoJA)
# Cambio di colori a piacimento (colorRampPalette si può usare solo su immagine singole, non su RGB)
cls<-colorRampPalette(c("red","blue","yellow","white"))(100)
# Nuovo levelplot col cambio di colori, nome e titolo
levelplot(PoJA,col.regions=cls, main="Variation ice cover in time", names.attr=c("Nov","Jan"))
---------

# MULTIVARIATE ANALYSIS

# 1. Le coppie di funzioni producono una matrice di scatterplot.

# Traccia le correlazioni tra le 3 bande del mio stack.
# I valori di correlazione degli indici vanno da 0 a 1: 1= correlazione, 0 = nessuna correlazione
# Plot di tutte le correlazioni tra bande di un dataset (matrice di scatterplot di dati, non immagini)
# La tabella riporta in diagonale le bande (sono le variabili)
pairs(PoJA, main="Comparation with the function pairs")#??????
# Result= 0.81
# Indice di correlazione: più le bande sono correlate e maggiore sarà la dimensione dei caratteri

# Importazione delle singole immagini per effettuare comparazioni
# Funzione: brick, importa i singoli file per avere dati e immagini a 3 bande
# Non utilizzo la funzione raster perchè successivamente farò l'analisi della PCA nella quale servono almeno 2 bande 

poyangJ <- brick("poyang_oli_2022191_lrg.jpg") # July
poyangA <- brick("poyang_oli_2022239_lrg.jpg")# August

par(mfrow=c(1,2))
plotRGB(poyangJ, r=1, g=2, b=3, stretch="lin")
plotRGB(poyangA, r=1, g=2, b=3, stretch="lin")



# ora applichiamo l'algebra applicata alle matrici 
#utilizzo raster perchè non mi interessa ad avere le 3 bande divise ma una immagine con un'unica banda 
poyang1 <- raster("poyang_oli_2022191_lrg.jpg") # July
poyang2 <- raster("poyang_oli_2022239_lrg.jpg")# August

#vogliamo fare la sottrazione tra il primo e l'ultimo dato 
# $ il dollaro mi lega il file originale al file interno 
Pwater <- poyang1 - poyang2
# creo una nuova colour and palette 
clb <- colorRampPalette(c("red","white","yellow"))(100)
plot(Pwater, col=clb) # zone rosse no acqua
# usiamo level per avere una gamma di colori più dettagliata 
levelplot(Pwater, col.regions=clb, main="Scioglimento del ghiaccio dal 1986 al 2019")

# 2. Analisi delle componenti principali

# PCA July
poyang1_pca <- rasterPCA(poyangJ)
summary(poyang1_pca$model)
# Importance of components:
#                             Comp.1     Comp.2      Comp.3
# Standard deviation     109.2553346 59.9319584 27.67877126
# Proportion of Variance   0.7325536  0.2204302  0.04701622
# Cumulative Proportion    0.7325536  0.9529838  1.00000000

plotRGB(poyang1_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(poyang1_pca$model) # per vedere il grafico

#PCA August
poyang2_pca <- rasterPCA(andes2)
summary(poyang2_pca$model)
# Importance of components:
#                             Comp.1     Comp.2      Comp.3
# Standard deviation     109.2553346 59.9319584 27.67877126
# Proportion of Variance   0.7325536  0.2204302  0.04701622
# Cumulative Proportion    0.7325536  0.9529838  1.00000000

plotRGB(poyang2_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(poyang2_pca$model) # per vedere il grafico

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
ClAn1 <- unsuperClass(andes1, nClasses=3)  
ClAn2 <- unsuperClass(andes2, nClasses=3)  

# metto le immagini insieme per avere una mappa della situazione 
par(mfrow=c(1,2)) # 3 colonne e 2 righe
plot(ClAn1$map)
plot(ClAn2$map)

#ora proviamo a calcolare la frequenza dei pixel di una certa classe.
#lo possiamo fare con la funzion freq 

set.seed(42)
plot(ClAn1$map)
freq(ClAn1$map)  # freq è la funzione che mi va a calcolare la frequenza 
#value   count
#[1,]     1 2596548 vegetazione
#[2,]     2 2511074 roccia
#[3,]     3  617378 neve e ghiaccio


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


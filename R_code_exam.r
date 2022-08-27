 #  Il ritiro del ghiacciaio Columbia in Alaska dal 1986 al 2019
 # immagini prese dal sito: https://earthobservatory.nasa.gov/world-of-change/ColumbiaGlacier
 # È uno dei ghiacciai che cambia più rapidamente nel mondo
 # Le instabilità dinamiche sono comuni ai ghiacciai marini-terminali e permettono un trasferimento di massa terra-mare molto rapido, 
 # tanto che questi ghiacciai costituiscono una delle più grandi componenti dell'innalzamento globale del livello del mare eustatico




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

Andes1 <- brick("andes_oli_20213321_lrg.jpg")
Andes2 <- brick("andes_oli_20220151_lrg.jpg")

par(mfrow=c(1,2))
plotRGB(Andes1, r=1, g=2, b=3, stretch="lin")
plotRGB(Andes2, r=1, g=2, b=3, stretch="lin")



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


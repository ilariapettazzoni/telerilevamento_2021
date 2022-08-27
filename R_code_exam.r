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
# settaggio della working directory 
setwd("/Users/ilari/Desktop/lab/")
# Importo i file tutti insieme (invece che singolarmente) utilizzando la funzione stack
# Funzione list.files: crea lista di file per la funzione lapply 
clist <- list.files(pattern="andes") # pattern = è la scritta in comune in ogni file, nel mio caso è columbia 
# per ottenre le informazioni sui file 
clist
# [1] "1 columbia_tm5_1986209_lrg.jpg"          
# [2] "2 columbia_tm5_1995202_lrg.jpg"          
# [3] "3 columbia_etm_2001258_lrg.jpg"          
# [4] "4 columbia_tm5_2005245_lrg.jpg"          
# [5] "5 columbia_oli_2013203_lrg.jpg"          
# [6] "6 columbiaglacier653_oli_2019172_lrg.jpg"

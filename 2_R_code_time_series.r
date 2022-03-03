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
 
# list f files: Mi serve qualcosa in comune a tutti i file della lista. Es “lst”. E’ il pattern, cioè una frase in comune
rlist <- list.files(pattern="lst")
rlist
# R mi restituisce la lista dei file

#Creo una lista di file di quella cartella che hanno in comune la parola lst. A questo punto li importo.
#lapply(x,fan) con x=lista e fan=funzione da applicare
import <- lapply(rlist,raster)
import
#R mi restituisce le info dei 4 file importati

#ora impacchettiamo  file  con la funzione stack

#funzione STACK per plottare tutte le immagini. Faccio un blocco di files tutti insieme. 
#Raster stack per raggruppare file raster. Lo raggruppo in un file detto TGr. Stack mi passa dai singoli files ad un unico file grande. 
TGr <- stack(import)
TGr
plot(TGr)

#funzione RGB
plotRGB(TGr, 1, 2, 3, stretch="Lin") 
#con il plotRGB vediamo una sovrapposizione di 3 immagini, 2000-2005-2010. Siccome sulla componente green abbiamo messo il 2005.
#se ho dei colori verdi ho dei valori più alti di lst nel 2005, se i colori sono rossi ho un lst più alto nel 2000, se ho colori blu ho dei valori più alti di lst nel 2010.

plotRGB(TGr, 2, 3, 4, stretch="Lin") 
plotRGB(TGr, 4, 3, 2, stretch="Lin") 

#installo il pacchetto rasterVis (all'inizio)

#LEZIONE 09/04/21

#plottiamo i dati di copernicus assieme
levelplot(TGr)
#plot grafico prima immagine, il dollaro lega lo strato dello stack allo stack stesso.

levelplot(TGr$lst_2000)
#con il plot di un singolo file ai lati dell'immagine ci sono dei grafici. questi grafici riportano il valore medio di lst della colonna o della riga.

#cambio colore
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)

#uso col.regions per levelplot
#Il levelplot è più potente di plot per output colori e mi permette di confrontare più facilmente, più compatto e potente.
#Le coordinate sono solo sulla destra e sotto. I colori si vedono meglio. I titoli delle singole mappe sono i nomi dei vari livelli, possiamo anche cambiarli. 
levelplot(TGr, col.regions=cl)
#la differenza con il plot normale è che il levelplot ha una gamma di colori molto maggiore ed ha un outpot migliore.

#rinomino gli attributi
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#inserisco il titolo del grafico
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# Melt
#dati scioglimento
meltlist <- list.files(pattern="melt")
melt_import <- lapply(meltlist,raster)
melt <- stack(melt_import)
melt

levelplot(melt)
#useremo le immagini del '79 e 2007 per vedere la differenza nello scioglimento.
#facciamo 2007-1979 più sarà alto il risultato maggiore sarà stato lo scioglimento
#sottrazione tra l'ultimo e il primo dato per ottenere il livello di scioglimento, il $ lega lo stack allo strato interno 

melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

#dal blu al rosso aumenta lo scioglimento
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)

levelplot(melt_amount, col.regions=clb)

#installo il pacchetto knitr
install.packages("knitr")




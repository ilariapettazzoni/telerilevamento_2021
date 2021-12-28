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




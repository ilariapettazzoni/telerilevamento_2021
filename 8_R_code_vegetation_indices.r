#R_code_vegetation_indices.r

library(raster)
#si può usare anche require(raster)
install.packages("rasterdiv")
#library(rasterdiv) 
#for the worldwide NDVI
library (rasterdiv)
setwd("/Users/ilari/Desktop/lab")

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
# b1 = NIR, b2 = red, b3 = green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

defor1

#nel plot si nota che il fiume ha due colori diversi, nella prima immagine l'acqua ha un contenuto di solidi sciolti molto maggiore rispetto alla seconda immagine.
#questo si capisce dal fatto che l'acqua è chiara, assorbendo molto nell'infrarosso il suo colore teoricamente è scuro, se è acqua pura diventa nera

#la parte rossa è la vegetazione, la parte chiara è suolo agricolo, suolo nudo e le patch rosse sono suolo agricolo con vegetazione.

#NDVI è uno dei principali indici di vegetazione.
#le piante in genere riflettono molto nel NIR e assorbe il rosso, quando il rosso assorbe la foglia solo una piccola parte viene riflessa. 
#se nell'immagine satellitare ho un pixel con vegetazione ho la possibilità di misurare quanto è sana la vegetazione.

#DVI= NIR - red
#il range possibili va da 255 a -255. il valore negativo indica assenza di vegetazione viva.
#c'è la possibilità di normalizzare l'indice attraverso il rapporto con la somma NIR + red.

# difference vegetation index

# time 1
#NIR-Red
dvi1 <- defor1$defor1.1 - defor1$defor1.2
# in ogni pixel dell'immagine stiamo andando a fare questa sottrazione e creare poi una mappa

# dev.off()
plot(dvi1)


cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
# specifying a color scheme

plot(dvi1, col=cl, main="DVI at time 1")

# time 2
dvi2 <- defor2$defor2.1 - defor2$defor2.2

plot(dvi2, col=cl, main="DVI at time 2")

#confronto le immagini con par()
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

#per la differenza nei 2 tempi possiamo fare la sottrazione tra i 2 dvi.
difdvi <- dvi1 - dvi2
# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)


#nel risultato ottenuto avremo la colorazione rossa dove la differenza è maggiore, dove è minore ci sarà prima il bianco e poi il blu.
#in poche parole dove la differenza è maggiore sono i luoghi in cui la vegetazione ha sofferto maggiormente.

#la stessa cosa vale con l'NDVI
#questo spesso è più usato del DVI perchè quando si vanno a confrontare immagini a diversi bit (ad esempio una 8 con una a 16) risulta impossibile vista la diversa risoluzione radiometrica.
#per questo è nato il NDVI che normalizza i valori sulla somma delle variabili.
#questo procedimento fa si che indipendentemente dal numero di bit il range dell'NDVI va da -1 (valore minimo, con vegetazione morta) a 1 (valore massimo, con vegetazione rigogliosa)

# NDVI
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

# nel pacchetto RStoolbox ci sono già una serie di indici, tra cui l'NDVI e il SAVI. 
# questo è un indice che prende in considerazione l'influenza del suolo nella riflettanze di un'immagine.
# la funzione che calcola questi indici è spectralIndicies()

# RStoolbox::spectralIndices
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi1, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)
#alcuni indici necessitano del redEdge. il redEdge, nel grafico della firma spettrale, è la slope/pendenza tra la banda del rosso (valore basso) e quella del NIR (valore alto).
#più è alta la pendenza e più sana è la vegetazione. Se la veg sta morendo, quindi non assorbe il rosse e inizia ad assorbire il NIR la slope si abbassa.


#LEZIONE 05/05/21
# worldwide NDVI
plot(copNDVI)

#la funzione cbind() permette di eliminare/cambiare dei valori.
#possiamo togliere tutta la parte che comprende acqua.

# Pixels with values 253, 254 and 255 (water) will be set as NA’s.
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
library (rasterVis)
# rasterVis package needed:
levelplot(copNDVI)

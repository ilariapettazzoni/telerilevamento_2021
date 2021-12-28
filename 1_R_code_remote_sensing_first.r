# My first code in R for remote sensing!

#Set della working directory: la cartella da cui estraggo i dati per il codice. Dipende dal sistema operativo, su windows es: setwd("C:/lab")
setwd("/Users/ilari/Desktop/lab/")

#nella lezione precedente install.packages("raster")
#Installare i pacchetti: mi permette di utilizzare le funzioni nei codici. install.packages(“raster”), utilizzo le virgolette perché sto uscendo da R. 
#Dopo l’installazione, basta utilizzare la funzione library per richiamarli, senza virgolette perché sono già dentro R (li ho installati): library(raster). 
#Le librerie vanno richiamate sempre all’inizio. 
library(raster)

#Importare i dati: funzione brick  brick(“nome immagine.estensione”), con virgolette perché esco ed entro da R. 
#Se subito dopo scrivo il nome dell’immagine posso ottenere le varie info: numero di pixel, sistema di riferimento.
p224r63_2011<-brick("p224r63_2011_masked.grd")
p224r63_2011

#Visualizzare l’immagine: posso plottarla. Funzione plot(nome dell’immagine). 
#La funzione restituirà una scala di colore di defoult. 
plot(p224r63_2011)

#Colour change: per cambiare la scala posso scegliere una color diversa con la funzione colorRampPalette. 
#Colori indicati come etichette tra virgolette. 
#Per dire al software che si tratta di elementi dello stesso tipo devo racchiuderli in un oggetto, un vettore (array).
#Li raggruppo in parentesi con davanti una c, saranno elementi uniti per rappresentare un argomento, il colore. 
#L’argomento con il numero indica quanti livelli di ciascun colore voglio visualizzare. 
#Associo sempre il tutto ad un oggetto (cl) così da facilitare l’utilizzo del codice, posso scrivere solo l’oggetto e non tutta la funzione. 
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

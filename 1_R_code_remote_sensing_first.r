# My first code in R for remote sensing!

#Set della working directory: la cartella da cui estraggo i dati per il codice. Dipende dal sistema operativo, su windows es: setwd("C:/lab")
#le virgolette ("...")sono utilizzate quando devo uscire da R. 
#nel percorso e fra la funzione e la parentesi non vanno inseriti spazi. 

setwd("/Users/ilari/Desktop/lab/")

# ..dovremo usare la funzione brick("...")
#la funzione brick è all'interno del pacchetto raster. quindi dobbiamo richiamare il pacchetto installato nella lezione precedente install.packages("raster")
#Installare i pacchetti: mi permette di utilizzare le funzioni nei codici. install.packages(“raster”), utilizzo le virgolette perché sto uscendo da R. 
#per richiamre i pacchetti serve la funzione library. Senza virgolette perché sono già dentro R (li ho installati): library(raster). 
#Le librerie vanno richiamate sempre all’inizio. 
 
library(raster)

#Importare i dati: funzione brick: brick(“nome immagine.estensione”), con virgolette perché esco ed entro da R. 
#Se subito dopo scrivo il nome dell’immagine posso ottenere le varie info: numero di pixel, sistema di riferimento.
#Si usa brick se i dati raster sono dati dalla composizione di più bande (1 per ogni sensore).
#Con il simbolo <- associamo il file ad un nome.

p224r63_2011<-brick("p224r63_2011_masked.grd")
p224r63_2011

#scrivendo solo il nome otteniamo diverse informazioni del file:
#il file è dato da una serie di bande in formato raster. le dimensioni sono di 1499 (numero di righe), 2967 (num di colonne), 4447533 (numero di celle, di pixel) e 7 (numero di layer)
#la risoluzione è di 30mx30m, è il satellite landsat.
#le bande, sre sta per spectral reflectance. la banda 6 è la banda termica.
#il numero totale di pixel è dato da 4447533 x 7 (ogni banda)
#B1=Blu, B2=verde, B3=rosso, B4=NIR, oggetti che riflettono di più hanno valori più alti, mentre oggetti che assorbono di più hanno valori più bassi.
#nella B4 le piante hanno valori molto alti perchè riflettono molto.

#plot è la funzione che permette di visualizzare l'immagine. non servono le virgolette perchè l'oggetto è già dentro a R.
#La funzione restituirà una scala di colore di defoult. 

plot(p224r63_2011)

#Colour Change
#Per cambiare la scala posso scegliere una color diversa con la funzione colorRampPalette. 
#Colori indicati come etichette tra virgolette. 
#Per dire al software che si tratta di elementi dello stesso tipo devo racchiuderli in un oggetto, un vettore (array).
#Li raggruppo in parentesi con davanti una c, saranno elementi uniti per rappresentare un argomento, il colore. 
#L’argomento con il numero indica quanti livelli di ciascun colore voglio visualizzare. 
#Associo sempre il tutto ad un oggetto (cl) così da facilitare l’utilizzo del codice, posso scrivere solo l’oggetto e non tutta la funzione. 

cl <- colorRampPalette(c("black","grey","light grey")) (100)

#la c davanti alle parentesi indica una serie di elementi appartenti allo stesso array.
#100 indica il numero di livelli tra il nero e il grigio chiaro. 

plot(p224r63_2011, col=cl)

#plot ma aggiungo un secondo elemento: il primo rimane la nostra immagine p224r63_2011, 
#il secondo argomento è la scala di colori appena creata. 
#importante è mettere la virgola tra gli argomenti.

#Colour Change 2

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

#dev.off pulisce la finestra grafica. 
dev.off()

#per plottare solo la banda 1 uso  la funzione plot, ma nelle parentesi metto:
plot(p224r63_2011$B1_sre)
#il simbolo del dollaro $ in R viene sempre usato per legare 2 pezzi, nel nostro caso la banda 1 all'immagine satellitare.

#plot banda 1 con una diversa colorRampPalette:
cls <- colorRampPalette(c("orange","yellow","light green")) (200)
plot(p224r63_2011$B1_sre, col=cls)

#Funzione PAR per plottare più immagini insieme nello stesso grafico e creare un multiframe. Mi permette di creare un sistema di righe e colonne. 

# 1 riga e 2 colonne
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 2 righe e una colonna
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# par(mfcol=c(1,2) dichiaro prima il numero di colonne

#plot delle prime 4 bande di Landsat:

#4 righe 1 colonna:
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#2 righe 2colonne:
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#2 righe 2 colonne  con una colorRampPalette specifica di ogni banda:
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

#Per ogni singola lunghezza d’onda abbiam uno specifico sensore. Se uso i sensori del blu, rosso e verde vedrò come l’occhio umano, nel sistema RGB. 
#Monto le tre bande una sull’altra. 
#La banda del verde nella componente green del nostro sistema. E così per le altre due. Secondo un ordine 3-2-1 (rosso, verde, blu).
#Argomento stretch: prendo i valori delle singole mappe e le “tiro” un po’ per fare in modo che non ci sia un schiacciamento verso una sola parte del colore. 
#R=B3 (banda del rosso), G=B2 (banda del verde), B=B1 (banda del blu). 

#immagine a colori naturali
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
#l'elemento stretch(in questo caso lineare) prende la riflettanza delle singole bande e la "tira"  per evitare che ci sia una banda preponderante. 

# Montiamo la 4 che è l’infrarosso sulla componente red, la 3 che è il rosso sulla componente green e la 2 che è il verde sulla componente blu. 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#siccome abbiamo montato la B4 nella componente R di RGB e la vegetazione ha un'altissima riflettanza nel NIR,
#la vegetazione prende il colore Red.
#in generale per gli studi di vegetazione si usa l'IR sulla componente Red di RGB.

#NIR nella componente green
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#in questo modo risultano più evidenti alcune info come ad esempio corsi d'acqua interni alla foresta oppure il suolo nudo, visibile in viola.
#Il viola è la componente agricola, in questo caso.


plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
#Tutti gli oggetti che hanno alta riflettanza nella banda numero 4 assumeranno il colore della componente alla quale la banda numero 4 è stata associata.

#uso par() per un riepilogo
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#Funzione pdf
#per creare un pdf con i grafici appena creati va aggiunta la funzione pdf() prima della serie di funzioni.
#Siamo dentro R, vogliamo prendere il grafico, uscire e portarlo nella cartella che ci interessa. 
#Se usciamo o entriamo in R usiamo sempre le virgolette, con il nome dentro. 

pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

#lo stretch può essere hist (istogramma)
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Hist")
#lo stretch ottenuto con hist permette di aumentare ulteriormente la possibilità di guardare all'interno della foresta. 
#In evidenza le zone più umide.

#par natural colours, false colours, false colours with histogram stretch
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Hist")

install.packages("RStoolbox")
library(RStoolbox)
#installo il pacchetto RStoolbox per la prossima lezione

# LEZIONE 5
# Multitemporal set

library(raster)
setwd("/Users/ilari/Desktop/lab/")

#analisi multitemporale, assegno le immagini dell'88 e del 2011
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
#nel plot il colore violetto è una parte di haze, corpuscoli che riflettono alcune lunghezze d'onda. 
#ovviamente le correzione dell'88 non sono come le attuali, di conseguenza non sono stati tolti questi effetti.

#NIR nel rosso
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#paragone 1988-2011
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#con stretch hist evidenzio le zone umide
#hist utilizza una curva sinusoide (o funzione logistica). 
#la pendenza maggiore ha un effetto grafico maggiore.
#la differenziazione tra rocce, o sabbie ad esempio è più ampia
#la granulometria influenza molta riflettanza ma con il lineare non si vede la differenza tra sabbia e argille, ma con un hist si può apprezzare.


par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Hist")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Hist")

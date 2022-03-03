#R_code_complete.r -Telerilevamento Geoecologico
#-----------------------------------------------

#Summary:

# 1 - Remote Sensing First Code
# 2 - Remote Code Time Series
# 3 - R Code Copernicus
# 4 - R Code Kintr
# 5 - R Code Multivariate Analysis
# 6 - R Code Classification
# 7 - R Code ggplot2
# 8 - R Code Vegetation Indices
# 9 - R Code Land Cover
# 10 - R Code Variability
# 11 - R Code Spetral Signatures
#-----------------------------------------------
#_______________________________________________

# 1 - Remote Sensing First Code

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


#LEZIONE 10/03/21

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

# par(mfcol=c(1,2) con mfcol dichiaro prima il numero di colonne

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


# LEZIONE 12/03/21
# Visualizing data by RGB plotting

#uniamo più bande in un unico plot

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

# LEZIONE 17/03/21
# Multitemporal set analysis

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

#-----------------------------------------------
# 2 - Remote Code Time Series

# LEZIONE 07/04/21

#Time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

library(raster)
setwd("/Users/ilari/Desktop/lab/greenland")

install.packages("rasterVis")
library(rasterVis)

# creiamo uno stack, ovvero un insieme di dati. Nel nostro caso saranno raster.
#importo le immagini singolarmente perchè sono 4
#(non posso usare brick)
#ogni strato in questo caso rappresenta la stima della temperatura superficiale (lst) che deriva dal programma copernicus.

#LST= Land Surface Temperature
#uso la fuzione raster invece di brick
#i nostri dati mostrano la temperature media dei primi 10gg di giugno nei 4 anni.


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
#la scala graduta: le immagini sono codificate in bit. la riflettanza viene espressa tra 0 e 1. altri tipo di set hanno altri formati, tra cui bit. molte immagini sono a 8 bit.
#i singoli decimali della temperatura sono molto pesante. la immagini che usiamo pesano qualche mega.
#invece di usare i decimali si usano i valori interi e per passare da una scala decimale ad una intera si usano i bit.
#DN=digital numbers. 
#2 elevato al numero di bit mi da il numero totale di possibili valori (interi) da associare ad un pixel. con 1 bit ho 2 possibili valori. con 2 bit ho 4 possibili valori etc.
#molte immagini sono a 8 bit, quindi abbiamo 256 valori possibili (2^8). le immagini a 16 bit hanno 65535 possibili valori, proprio come quelle che stiamo usando adesso.
#questo ci permette di non avere i decimali e in alcuni punti ci saranno dei valori ripetuti, permettendo di ridurre il peso finale dell'immagine
#magiore sarà il valore del DN maggiore sarà la temperatura dell'area.


#per importare tutte le immagini assieme
#uso la funzione lapply, ma prima creo la lista di file (list.files)a cui applicare la funzione raster
#i file hanno in comune le lettere "lst" nel nome
 
# list f files:
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

#levelplot()
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
#dati sciolglimento
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

#-----------------------------------------------

#3 - R Code Copernicus

#R_code_copernicus.r
#Visualizing Copernicus Data
#libreria per leggere il formato nc

install.packages("ncdf4")
library(ncdf4)
library(raster)
setwd("/Users/ilari/Desktop/lab")

test <- raster("c_gls_SWI1km_202108181200_CEURO_SCATSAR_V1.0.1.nc")
#la risoluzione è in gradi, non in metri, sono quindi coordinate geografiche.
#il sistema di riferimento è il WGS84

plot(test)
clt <- colorRampPalette(c("dark green","green","white"))(100)
plot(test, col=clt)

#resampling: ricampionamento lineare, riduco i pixel
#questo dato si può ricampionare per ottenerne uno con pixel più grandi e alleggerirlo.
#per ricampionare l'immagine uso la funzione aggregate
testsam<- aggregate(test, fact=10)
plot(testsam, col=clt)
#questo tipo di ricampionamento di chiama bilineare, prende 2 line di pixel e fa la media dei pixel all'interno.


install.packages("knitr")
install.packages("RStoolbox")
library(knitr)
library(RStoolbox)

ext <- c(6, 20, 35, 50)
testc <- crop(test, ext)
plot(testc)

#-----------------------------------------------

# 4 - R Code Kintr

#LEZIONE 16/04/21

#R_code_knitr.r
#Knitr è una funzione che mi permette di creare un report automatico del mio codice. Do un nome al mio codice e lo uso per fare un template, un file finale. 
#Il template è all’interno di knit r, pacchetto.

setwd("/Users/ilari/Desktop/lab/")
library(knitr)

# starting from the code folder where framed.sty is put!
# stitch() il primo argomento è come si chiama il codice, argomento 2 è il template che andiamo ad utilizzare (misc) 
# e il file del template che si chiama knit template, argomento 3 è il nome del pacchetto da utilizzare (knitr)
require(knitr)
stitch("R_code_greenland.tex", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#prima di tutto apro il codice di cui mi interessa fare il report e lo salvo nella cartella (lab ne nostro caso).
#il primo argomento di stich è il nome del file contenente il codice e la sua estensione.
#in questo modo leggerà automaticamente tutto il codice e creerà il report.
#il template è l'altro argomento che ci ha fornito riettamente il prof
#l'ultimo è il tipo di pacchetto che andiamo ad utilizzare

install.packages("tinytex")
library(tinytex)
#non fuziona


#-----------------------------------------------

# 5 - R Code Multivariate Analysis

#R_code_multivariate_analysis
#Quando ho tante bande con info correlate è utile compattare i dati attravrso l’analisi multivarita per vedere tutto il sistema in pochissime bande.

library(raster)
library(RStoolbox)

setwd("/Users/ilari/Desktop/lab")

#uso brick per caricare un set multiplo di dati
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
p224r63_2011

#plottiamo la banda 1 contro la banda 2
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
#plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre)
#l'ordine delle 2 bande dipende dall'ordine scritto nella funzione.
#cambio colore e il carattere dei punti ed aumento la dimensione

#le bande invertite invertono gli assi
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)

#pairs(): per plottare tutte le variabili possibili, mette in correlazione tutte le variabili a due a due del dataset
pairs(p224r63_2011)
#nella parte bassa della matrice troviamo i grafici con tutte le correlazioni, nella parte alta invece gli indici di correlazione di pearson.
#se siamo positivamente correlate l'indice tende a 1, se lo siamo negativamente tende a -1.
#grazie a pairs vediamo quanto molte bande siano correlate tra loro.


#LEZIONE 28/04/21

library(raster)
library(RStoolbox)

setwd("/Users/ilari/Desktop/lab")

# Funzione pairs:invece di fare manualmente la correlazione tra bande, posso usare la funzione pairs che mi permette di fare la correlazione a due a due di tutte le bande.
p224r63_2011 <- brick("p224r63_2011_masked.grd")
pairs(p224r63_2011)
p224r63_2011

#Funzione aggregate per aggregare raster.
# aggregate cells: resampling (ricampionamento)del dato per avere una risoluzione più bassa e un dato più leggero
# perchè la PCA è un processo lungo e complesso, alleggeriamo per rendere meno pesante il dato


p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

#rasterPCA prende il pachetto di dati e lo compatta in un numero minore di bande
#PCA: prendo i dati originali e passo da una variabilità maggiore ad una minore, che sia però rappresentativa. 
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

#Tramite la funzione summary posso ottenere un sommario del modello, posso capire in che percentuale le componenti sono rappresentative. 
#chiediamo info sul modello, usiamo $model
summary(p224r63_2011res_pca$model)
#la funzione summary è una funzione del pacchetto di base che crea un sommario del modello (in questo caso)
#dal risultato notiamo che la prima banda ha lo 0.998 della varianza totale, quindi quasi il totale della variabilità è contenuto in una banda sola.
#per avere il 100% della variabilità ovviamento dobbiamo usare tutte le bande, ma non è il nostro scopo. noi vogliamo la max variabilità con il minimo delle bande.
#anche nel plot delle immaini è così! nella banda 1 riusciamo a vedere tutto, foresta, zone agricole etc, nella banda 7 praticamente abbiamo solo rumore, un'immagine in cui è difficile distinguere le componenti.

#Posso fare un plot RGB per inserire le prime tre componenti, quelle che riassumono di più la varaibilità. 
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

#-----------------------------------------------

# 6 - R Code Classification


#R_code_classification.r
#LEZIONE 21/04/21

#Classificazione dei dati: processo che accorpa pixel con valori simili a rappresentanza di una classe. 

library(raster)
library(RStoolbox)

setwd("/Users/ilari/Desktop/lab")

#carico l'immagine con a funzione brick. uso brick perchè l'immagine è già creata, i 3 livelli rgb sono già uniti nell'immagine.

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
so
#visualize RGB levels
plotRGB(so, 1,2,3, stretch="lin")

#Unsupervised Classification
#i punti iniziali per la classificazione (training site) li recupera direttamente il software.
#per questo motivo si definisce "Unsupervised classification"
#la funzione utilizzata è unsuperClass, tra gli argomenti della funzione abbiamo:
#il numero del file da usare, il numero di pixel da usare come training site, il numero di classi

soc <- unsuperClass(so, nClasses=3)
#Ottenuto l’oggetto soc, possiamo plottare l’immagine. Abbiamo creato il modello di classificazione.

#Uso $map perchè abbiamo anche il modello all'interno. La funzione unsuperclass ha creato in uscita tutta la parte sul modello (quanti punti ha usato etc…) e la mappa in uscita. 
#Quando plottiamo abbiamo un oggetto soc formato da tanti pezzi. 
plot(soc$map)
#per avere lo stesso  tipo di classificazione
set.seed(42)

#Unsupervised Classification 20 classes
#Possiamo aumentare il numero di classi, l’occhio umano non può discriminare 20 classi con energia diversa ma il softwere si. 
sov <- unsuperClass(so, nClasses=20)
#uso $map perchè abbiamo anche il modello all'interno
plot(sov$map)


sun <- brick("The_Sun_viewed_by_Solar_Orbiter_s_PHI_instrument_on_18_June_2020_pillars.png")
sun
plotRGB(sun, 1,2,3, stretch="lin")
sunc <- unsuperClass(sun, nClasses=20)
#uso $map perchè abbiamo anche il modello all'interno
plot(sunc$map)

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soc20$map,col=cl)

#LEZIONE 23/04/21
# Download Solar Orbiter data and proceed further!

# Grand Canyon
# https://landsat.visibleearth.nasa.gov/view.php?id=80948

# When John Wesley Powell led an expedition down the Colorado River and through the Grand Canyon in 1869, he was confronted with a daunting landscape. At its highest point, the serpentine gorge plunged 1,829 meters (6,000 feet) from rim to river bottom, making it one of the deepest canyons in the United States. In just 6 million years, water had carved through rock layers that collectively represented more than 2 billion years of geological history, nearly half of the time Earth has existed.

#importo l'immagine con la funzione brick. brick infatti ci permette di caricare immagini satellitari già pronte, con le bande impacchettate.
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")

gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)

gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)


#-----------------------------------------------

# 7 - R Code ggplot2

 
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("~/lab/")
p224r63 <- brick("p224r63_2011_masked.grd")
ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")
p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")
grid.arrange(p1, p2, nrow = 2) # this needs gridExtra


#-----------------------------------------------

# 8 - R Code Vegetation Indices

#R_code_vegetation_indices.r

library(raster)
#si può usare anche require(raster) invece di library(raster)

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
#worldwide NDVI
plot(copNDVI)

#la funzione cbind() permette di eliminare/cambiare dei valori.
#possiamo togliere tutta la parte che comprende acqua.

#Pixels with values 253, 254 and 255 (water) will be set as NA’s.
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
#copNDVI<-raster::reclassify(copNDVI, cbind(253:255, NA)) 
#il :: serve per legare la funzione al suo pacchetto, come il dollaro. questo non serve per forza, si fa per rendere noto a chi legge il codice il pacchetto da cui proviene la funzione.
  
library (rasterVis)
# rasterVis package needed:
levelplot(copNDVI)


#-----------------------------------------------
# 9 - R Code Land Cover

# R_code_land_cover.r

library(raster)
library(RStoolbox) 
# classification
# install.packages("ggplot2")
#La libreria ggplot2() pacchetto che ha delle funzioni per plottare le immagini in modo più potente tramite funzioni facili. 
library(ggplot2)

# install.packages("gridExtra")
library(gridExtra) 
# for grid.arrange plotting

setwd("/Users/ilari/Desktop/lab")

# NIR 1, RED 2, GREEN 3
#L’immagine sentilen è già elaborata e formata da tre bande. 
#Non posso importare con la funzione raster, importerebbe solo il primo livello. Utilizziamo la funzione brick, che porta nel software tutto il blocco. 
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

#con ggplot e RStoolbox ci sono funzioni per plottare immagini in maniera molto più potente. Una di queste è ggR
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")


defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#LEZIONE 07/05/21
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#par(mfrow=c(1,2)) la funzione par con ggRGB non funziona, bisogna usare gridEXTRA

# multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)
#grid.arrange ci permette di organizzare il nostro multiframe .


#Unsupervised Classification
#si chiama così perchè è il software che scegli random un campione di pixel nell'immagine da dividere in classi

d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map)
# class 1: forest
# class 2: agriculture
# set.seed() would allow you to attain the same results ...
#la divisioni in classi è random, nel senso che, anche se il numero è sempre 2, una volta la classe 1 è la foresta e la classe 2 la parte agricola 
#ma se chiudo R e rifaccio questa operazione si possono invertire.
#per evitare questa cosa esiste la funzione set.seed() che ci permette di assegnare un numero al risultato 
#(nel nostro caso la suddivisione in classi) della funzione così che non cambi mai.
#set.seed(42)

d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
# class 1: agriculture
# class 2: forest

d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

# frequencies
#calcolo la frequenza dei pixel di una certa classe con la funzion freq()
freq(d1c$map)

#numero di pixel di ogni classe:
#   value  count
# [1,]     1 306583
# [2,]     2  34709

s1 <- 306583 + 34709

#proporzione
prop1 <- freq(d1c$map) / s1
# prop forest: 0.8983012
# prop agriculture: 0.1016988

s2 <- 342726
prop2 <- freq(d2c$map) / s2
# prop forest: 0.5206958
# prop agriculture: 0.4793042

# build a dataframe
#metteremo nella prima colonna i fattori (variabili categoriche), nel nostro caso foresta e zona agricola.
#la seconda e la terza colonna conterranno le percentuali di copertura nei 2 anni(1992 e 2006)

cover <- c("Forest","Agriculture")
percent_1992 <- c(89.83, 10.16)
percent_2006 <- c(52.06, 47.93)

#dopo aver assegnato i valori che ci interessano ai nomi delle colonne usiamo la funzione data.frame() per ottenere la tabella.
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

# plottiamo con ggplot
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
#l'argomento color serve a strutturare la legenda del grafico


p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

grid.arrange(p1, p2, nrow=1)
#la funzione grid arrange ci permette di organizzare più grafici in un'unica finestra così da poterli confrontare.



#-----------------------------------------------

# 10 - R Code Variability
 
# R_code_variability.r
#LEZIONE 19/05/21

library(raster)
library(RStoolbox)
# install.packages("RStoolbox")
library(ggplot2) # for ggplot plotting
library(gridExtra) # for plotting ggplots together
# install.packages("viridis")
library(viridis) # for ggplot colouring


setwd("/Users/ilari/Desktop/lab")
#importo l'immagine del similaun con la funzione brick per poter importare l'intero dataset


sent <- brick("sentinel.png")
# NIR 1, RED 2, GREEN 3
# r=1, g=2, b=3
plotRGB(sent, stretch="lin") 
# plotRGB(sent, r=1, g=2, b=3, stretch="lin") 
#in questo caso posso evitare di scrivere 1,2,3 e lo stretch. perchè essendo un'immagine già processata con solo le bande che ci interessano di default va già bene.
#in questa immagine si vede bene l'acqua pura che prende il colore nero.

plotRGB(sent, r=2, g=1, b=3, stretch="lin") 
#per fare il calcolo della deviazione standard useremo solo una banda e al suo interno ci faremo passare la moving window che farà il calcolo.
# è una finestra che si muove sui pixel dell'immagine e permette di creare una nuova mappa 
#con associato ad ogni pixel un valore di deviazione standard calcolato non sull'intera immagine ma sui pixel contenuti nella finestra.
#questo processo però avviane solo su una banda, non su tutte. Dobbiamo quindi compattare tutte le bande. Per farlo possiamo usare degli indici di vegetazione.
#uno di questi è l'NDVI che è la sottrazione tra NIR e red diviso per la somma. così facendo otterremo la mappa dell'NDVI che è composta solo dalla banda NDVI.

nir <- sent$sentinel.1
red <- sent$sentinel.2

ndvi <- (nir-red) / (nir+red)
plot(ndvi)
#dove vediamo il bianco non c'è vegetazione, nel marroncino c'è la roccia, nel giallino/verdino sono le parti di bosco e il verde scuro sono le praterie

cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) 
plot(ndvi,col=cl)

ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
#la funzione focal mi permette di fare diversi calcoli statistici per mezzo della moving window
#gli argomenti nella funzione sono: il nome dell'immagine, la matrice (è la moving window) 
#questa più è grande più pixel prende in considerazione e più lungo sarà il calcolo.
#1/9 significa che prendi in considerazione ogni pixel sui 9 della matrice.


clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd3, col=clsd)
#la sd è più bassa nella parti più omogenee, mentra aumenta nelle zone dove si passa da roccia nuda a parte vegetata. Torna a diminuire nelle zone di prateria, in quanto più omogenee.
#ci sono piccole zone in aumento che corrispondono ai picchi più alti e crepacci.


# mean ndvi with focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clsd)

# changing window size
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd13, col=clsd)

ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd)

# PCA
sentpca <- rasterPCA(sent) 
plot(sentpca$map)  
#devo specificare $map perchè la funzione rasterPCA crea anche il modello


summary(sentpca$model)

# the first PC contains 67.36804% of the original information


pc1 <- sentpca$map$PC1

pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(pc1sd5, col=clsd)

# pc1 <- sentpca$map$PC1
# pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
# plot(pc1sd7)


#la funzione source() mi permette di importare in R un codice già pronto e vedere direttamente il risultato finale.
source("source_test_lezione.r")
source("source_ggplot.r")

# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
# The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties - “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”.
p1 <- ggplot() +
#con questa funzione abbiamo creato una finestra vuota
# per riempirla vanno aggiunti dei blocchi con il +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
#di questa funzione ne esistono molte, una per ogni geometria possibili (geom_point, geom_line etc)
#le estetiche in ggplot sono la parte plottata. la x, la y e tutti i valori al loro interno. tutto questo si inserisce nell'argomento mapping.
scale_fill_viridis()  +
#cambio della palette di colori
ggtitle("Standard deviation of PC1 by viridis colour scale")
#Viridis, colori che possano percepire tutti, pacchetto che garantisce che tutte le legende siano blindfriendly rispetto ad alcune malattie della vista.


#magma palette
p2 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma")  +
ggtitle("Standard deviation of PC1 by magma colour scale")

#turbo palette
p3 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "turbo")  +
ggtitle("Standard deviation of PC1 by turbo colour scale")

#grid.arrange:più grafici in una pagina. Deriva dalla libreria gridExtra. 
grid.arrange(p1, p2, p3, nrow = 1)


#-----------------------------------------------

# 11 - R Code Spetral Signatures
# R_code_spectral_signatures.r

#FIRME SPETTRALI  posso risalire al tipo di materiale o addirittura al tipo di pianta 
#foglie molto diverse e presentano delle firme spettrali diverse, riflettono a lunghezze d’onda differenti. 

library(raster)
library(rgdal)

setwd("/Users/ilari/Desktop/lab/")
defor2 <- brick("defor2.jpg")

plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

#La funzione click del pacchetto rgdal mi permette di ottenere informazioni cliccando su vari punti dell’immagine, in questo caso info sulla riflettanza. 
defor2
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#results:
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 348.5 229.5 178165      215        5       18
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 410.5 256.5 158868      168      141      114


band <- c(1,2,3)
forest <- c(215,5,18)
water <- c(168,141,114)
spectrals <- data.frame(band,forest,water)
attach(spectrals)
spectrals

ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=forest), color="green")

    
ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=forest), color="green") +
 geom_line(aes(y=water), color="blue") +
 labs(x="wavelength", y="reflectance")

#multitemporal
    
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

plotRGB(defor1, r=1, g=2, b=3, stretch="hist")
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
# x     y   cell defor1.1 defor1.2 defor1.3
#1 233.5 219.5 184446      213       13       26
 #    x     y  cell defor1.1 defor1.2 defor1.3
#1 22.5 353.5 88559      141       85       72

plotRGB(defor2, r=1, g=2, b=3, stretch="hist")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 115.5 252.5 161441      188       10       24
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 23.5 352.5 89649      190      176      173


# define the columns of the dataset:
band <- c(1,2,3)
time1 <- c(213,13,26)
time2 <- c(141,85,72)

spectralst <- data.frame(band, time1, time2)

# plot the sepctral signatures
ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time2), color="gray") +
 labs(x="band",y="reflectance")
 
 # define the columns of the dataset:
band <- c(1,2,3)
time1 <- c(223,11,33)
time1p2 <- c(218,16,38)
time2 <- c(197,163,151)
time2p2 <- c(149.157,133)

spectralst <- data.frame(band, time1, time2, time1p2, time2p2)

 # plot the sepctral signatures
ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time1p2), color="red") +
 geom_line(aes(y=time2), color="gray") +
 geom_line(aes(y=time2p2), color="gray") +
 labs(x="band",y="reflectance")

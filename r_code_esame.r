                    #Poyang Lake
                                                                   
#Poyang Lake, in China’s Jiangxi Province, routinely fluctuates in size between the winter and summer seasons. 
#In winter, water levels on the lake in are typically low. Then, summer rains cause the country’s largest freshwater lake to swell as water flows in from the Yangtze River.
#The lake has not swelled in the summer of 2022. 
#A prolonged heat wave and drought across much of the Yangtze River Basin dried the lake out early and pushed water levels to lows not seen in decades.

#The Operational Land Imager (OLI) on Landsat 8 acquired these pairs of images on July 10, 2022 (left images), and August 27, 2022 (right images). 
#The images are composites, and combine OLI observations of shortwave infrared, near infrared, and visible light.

                                                                   ------------------------

# Caricamento delle library necessarie al funzionamento dei codici :
library(raster)                                # permette l'utilizzo dei raster e funzioni annesse
library(rasterVis)                             # permette di visualizzare matrici e fornisce metodi di visualizzazione per i dati raster --> con questa libreria posso utilizzare la funzione levelplot
library(RStoolbox)                             # permette l'uso della Unsupervised Classification
library(ggplot2)                               # permette l'uso delle funzioni ggplot
library(gridExtra)                             # permette l'uso e creazione di griglie, tabelle e grafici
library(rgdal)                                 # per le firme spettrali
library(grid)                                  # Il pacchetto grid in R implementa le funzioni grafiche primitive che sono alla base del sistema di plottaggio ggplot2
library (rasterdiv)                            # Providing functions to calculate indices of diversity on numerical matrices based on information theory

# Settaggio della working directory 
setwd("/Users/ilari/Desktop/lab/Esame/")

#Importazione immagini
poyangJ <- brick("poyang_oli_2022191_lrg.jpg") # July
poyangA <- brick("poyang_oli_2022239_lrg.jpg")# August

#Plottaggio 2 immagini colori naturali
par(mfrow=c(1,2))
plotRGB(poyangJ, r=1, g=2, b=3, stretch="lin")
plotRGB(poyangA, r=1, g=2, b=3, stretch="lin")

# Plot stretch istogramma
par(mfrow=c(1,2))
plotRGB(poyangJ, r=3, g=2, b=1, stretch="hist")
plotRGB(poyangA, r=3, g=2, b=1, stretch="hist")


#Crop immagini per maggior dettaglio
ext1 <- c(600, 3000, 2000, 20000)        # coordinate (long ovest, long est, lat sud, lat nord)
ext2 <- c(600, 3000, 2000, 20000)        # coordinate (long ovest, long est, lat sud, lat nord)

pjcropped <- crop(poyangJ, ext1)
pacropped <- crop(poyangA, ext2)

#Salvo le immagini /////// Non lanciare su R
jpeg("pjcropped.jpg")
plotRGB(pjcropped, r=1, g=2, b=3, stretch="lin")
dev.off()

jpeg("pacropped.jpg")
plotRGB(pacropped, r=1, g=2, b=3, stretch="lin")
dev.off()
//////////////////////////////////////////////

#Importazione immagini
PJulyc <- brick("pjcropped.jpg")
PAuguc <- brick("pacropped.jpg")

#Plot immagini Croppate
par(mfrow=c(1,2)) # 2 colonne e 2 righe
plotRGB(PJulyc, r=1, g=2, b=3, stretch="lin")
plotRGB(PAuguc, r=1, g=2, b=3, stretch="lin")



# UNSUPERVISED CLASSIFICATION
#si chiama così perchè è il software che scegli random un campione di pixel nell'immagine da dividere in classi

set.seed(42)
#la divisioni in classi è random, nel senso che, anche se il numero è sempre 4, 
#una volta la classe 1 è la foresta e la classe 2 la parte agricola ma se chiudo R e rifaccio questa operazione si possono invertire.
#per evitare questa cosa esiste la funzione set.seed() che ci permette di assegnare un numero al risultato 
#(nel nostro caso la suddivisione in classi) della funzione così che non cambi mai.


#effettuiamo una categorizzazione in 6 classi di colore per distinguere le zone con ghiaccio, con acqua e "altro"
ClP1 <- unsuperClass(poyangJ, nClasses=6)  
ClP2 <- unsuperClass(poyangA, nClasses=6)  
colo <- colorRampPalette(c('yellow','orange','red','green','blue','purple'))(100) 

# metto le immagini insieme per avere una mappa della situazione 
par(mfrow=c(2,2)) # 2 colonne e 2 righe
plot(ClP1$map, col=colo)
plot(ClP2$map, col=colo)
plotRGB(poyangJ, r=1, g=2, b=3, stretch="lin")
plotRGB(poyangA, r=1, g=2, b=3, stretch="lin")

jpeg("class2.jpg")
plot(ClP2$map, col=colo)
dev.off()

#ora proviamo a calcolare la frequenza dei pixel di una certa classe.
#lo possiamo fare con la funzion freq 

set.seed(42)
plot(ClP1$map)
freq(ClP1$map)  # freq è la funzione che mi va a calcolare la frequenza 
#   value   count
#[1,]     1 3471646 altra vegetazione
#[2,]     2 9230548 foresta
#[3,]     3 1145575  suolo nudo nuvole
#[4,]     4 4843234 acqua
#[5,]     5 2528980 altra vegetazione
#[6,]     6 6347834 altra vegetazione

set.seed(42)
plot(ClP2$map)
freq(ClP2$map)  
#. value    count
#[1,]     1  3098838 altra vegetazione
#[2,]     2  3766096 altra vegetazione
#[3,]     3  1007263 acqua
#[4,]     4  12447007 foresta
#[5,]     5  4851411  altra vegetazione
#[6,]     6  2397202 dune + nuvole


# ora calcoliamo la proporzione 
#facciamo la somma dei valori 
s1 <- 3471646 + 9230548 + 1145575 + 4843234 + 2528980 + 6347834
s1 # [1] 27567817, questo valore deve essere uguale per tutti 

s2 <- 3098838 + 3766096 + 1007263 + 12447007 + 4851411 + 2397202
s2 #[1] 27567817

#per calcolare la proporzione facciamo la frequenza fratto il totale
prop1 <- freq(ClP1$map)/ s1
prop1
#       value      count
#[1,] 3.627418e-08 0.12593112
#[2,] 7.254836e-08 0.33483057
#[3,] 1.088225e-07 0.04155480
#[4,] 1.450967e-07 0.17568435
#[5,] 1.813709e-07 0.09173668
#[6,] 2.176451e-07 0.23026248

prop2 <- freq(ClP2$map) / s2
prop2

#  value      count
# [1,] 3.627418e-08 0.08841360
# [2,] 7.254836e-08 0.03388179
# [3,] 1.088225e-07 0.45612027
# [4,] 1.450967e-07 0.13425963
# [5,] 1.813709e-07 0.11243596
# [6,] 2.176451e-07 0.17488875


perc_dunes_1 <- 1145575 * 100 / 27567817
perc_dunes_1
#[1] 4.15548
perc_wat_1 <- 4843234 * 100 / 27567817
perc_wat_1
#[1] 17.56843
perc_veg_1 <- (3471646 + 9230548 + 2528980 + 6347834) * 100 / 27567817
perc_veg_1
#[1] 78.27609
perc_dunes_2 <- 2397202 * 100 / 27567817
perc_dunes_2
#[1] 8.695654
perc_wat_2 <- 1007263 * 100 / 27567817
perc_wat_2 
#[1] 3.653764
perc_veg_2 <- (3098838 + 3766096 + 12447007 + 4851411) * 100 / 27567817
perc_veg_2
#[1] 87.65058

cover <- c("acqua","dune","vegetazione")
July_10 <- c(17.64645, 4.487715, 78.27609)
August_28 <- c(3.388179, 8.84136, 87.65058)


# per crare il nostro data Frames uso la funzione data.frame
percentages <- data.frame(cover, July_10, August_28)
percentages
# cover percentWD1 percentWD2
#1       acqua  17.646450   3.388179
#2        dune   4.487715   8.841360
#3 vegetazione  78.276090  87.650580


v<-ggplot(percentages, aes(x=cover, y=July_10, color=cover)) + geom_bar(stat="identity", fill="violet")
y<-ggplot(percentages, aes(x=cover, y=August_28, color=cover)) + geom_bar(stat="identity", fill="yellow")
grid.arrange(v, y, ncol=2)


# metto in un unico grafico tutte le date posizionandolo in orizzontale
C1 <- ggplot(percentages, aes(x=cover, y=July_10, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C1 + coord_flip()
C2 <- ggplot(percentages, aes(x=cover, y=August_28, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C2 + coord_flip()

barsgraph <-grid.arrange(C1 + coord_flip(), C2 + coord_flip(), nrow=2)
ggsave("bars.jpg", barsgraph) 

# uso l funzione grid.arrange per mettere i grafici in una pagina  della gridextra già installato
circlegraph <- grid.arrange(C1 + coord_polar(theta = "x", direction=1 ), C2 + coord_polar(theta = "x", direction=1 )) 
         
ggsave("grid.arrange.jpg", circlegraph) 
# la funzione coord_polard mi permette di visualizzare il grafico in modo circolare e particolare

# R_code_land_cover.r

library(raster)
library(RStoolbox) # classification
# install.packages("ggplot2")
#La libreria ggplot2() pacchetto che ha delle funzioni per plottare le immagini in modo più potente tramite funzioni facili. 
library(ggplot2)
# install.packages("gridExtra")
library(gridExtra) # for grid.arrange plotting

setwd("/Users/ilari/Desktop/lab")

# NIR 1, RED 2, GREEN 3
#L’immagine sentilen è già elaborata e formata da tre bande. 
#Non posso importare con la funzione raster, importerebbe solo il primo livello. Utilizziamo la funzione brick, che porta nel software tutto il blocco. 
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")


defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#LEZIONE 07/05/21
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)


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
freq(d1c$map)
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
#la funzione grid arrange ci permette di organizzare più grafici in un'unica finestra così da poterli confrontare.


grid.arrange(p1, p2, nrow=1)




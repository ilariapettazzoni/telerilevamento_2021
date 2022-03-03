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

install.packages("tinytex")
library(tinytex)
#non fuziona


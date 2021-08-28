#LEZIONE 16/04/21

#R_code_knitr.r

setwd("/Users/ilari/Desktop/lab/")
library(knitr)

# starting from the code folder where framed.sty is put!

require(knitr)
stitch("R_code_greenland.tex", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

install.packages("tinytex")
library(tinytex)
#non fuziona


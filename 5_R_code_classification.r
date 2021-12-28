#R_code_classification.r
#LEZIONE 21/04/21

library(raster)
library(RStoolbox)

setwd("/Users/ilari/Desktop/lab")
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
so
#visualize RGB levels
plotRGB(so, 1,2,3, stretch="lin")

#Unsupervised Classification
soc <- unsuperClass(so, nClasses=3)
#uso $map perchè abbiamo anche il modello all'interno
plot(soc$map)
#per avere lo stesso  tipo di classificazione
set.seed(42)
#Unsupervised Classification 20 classes
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

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")

gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)

gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

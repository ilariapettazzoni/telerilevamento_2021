install.packages("GGally")
library(GGally)

ggpairs(iris[3:5], aes(color = Species, alpha = 0.5),
        lower = list(combo = "count"))

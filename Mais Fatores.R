####Mais Fatores

#Compartilhe com a gente um código criado por você com um processo de one hot encoding ou de discretização, e também a transformação dos fatores de uma base de dados em 3 tipos: mais frequente, segundo mais frequente e outros.


library(data.table)
library(dplyr)
library(forcats)

iris
glimpse(iris)
petalas <- iris
str (petalas)

# Discretização
(petalas$Sepal.Length.Disc <- discretize(petalas$Sepal.Length, method = "interval", breaks = 3, labels = c("pequena", 'média', 'grande')))


(petalas$Petal.Length<-as.factor(petalas$Petal.Length))

# conta os fatores
fct_count(petalas$Petal.Length)

# reclassifica os fatores em mais frequente, segundo mais frequente e outros
fct_lump(petalas$Petal.Length, n = 2)








#Compartilhe com a gente um código criado por você usando uma técnica de imputação numérica e uma técnica de hot deck para substituir NA.

#Utilizando a base "Fligths data"

library(nycflights13)
data("flights")
library(funModeling)
status(flights)

?flights

banco <- flights
summary(banco)

# Aplicando a técnica de imputação numérica por tendência central
#Os valores ausentes (NA) na variável "arr_time" foram substituídos pela mediana

library(Hmisc) # biblioteca que facilita imputação de tendência central

banco$arr_time <- impute(banco$arr_time, fun = median) # imputação da mediana
is.imputed(banco$arr_time) # testando se o valor foi imputado
table(is.imputed(banco$arr_time)) # tabela de imputação por sim / não

#Aplicando a técnica de imputação de valores semelhantes (hot deck)

# Imputação de valores semelhantes (hot deck)
# imputação por aleatoridade
(banco$air_time <- impute(banco$air_time, "random")) # aplicando a imputação aleatória

table(is.imputed(banco$air_time)) # tabela de imputação por sim / não



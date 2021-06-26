#Introdução a Datas e Tempos

#Criem um objeto próprio de data e tempo, convertam pros três formatos de data e tempo, e façam pelo menos 3 extrações de componentes e/ou operações.

dataNascmento <- c("2018-05-10 08:20", "2019-08-21 18:30", "2020-06-11 22:10", "2019-05-25 19:15", "2018-09-19 12:30",  "2021-03-18 10:10")

#Conversão para o formato data
(str(dataNascmento1 <- as.Date(c("2018-05-10 08:20", "2019-08-21 18:30", "2020-06-11 22:10", "2019-05-25 19:15", "2018-09-19 12:30",  "2021-03-18 10:10")) ) )


# Conversão para o formato POSIXct
(str(dataNascmento2 <- as.POSIXct(c("2018-05-10 08:20", "2019-08-21 18:30", "2020-06-11 22:10", "2019-05-25 19:15", "2018-09-19 12:30",  "2021-03-18 10:10") ) ))

unclass(dataNascmento2) # observamos o POSIXct no formato original (segundos)

# Conversão para o formato POSIXlt
(str(dataNascmento3 <- as.POSIXlt(c("2018-05-10 08:20", "2019-08-21 18:30", "2020-06-11 22:10", "2019-05-25 19:15", "2018-09-19 12:30",  "2021-03-18 10:10")) ) )
unclass(dataNascmento3) # observamos o POSIXlt no formato original (componentes de tempo)

###Extração dos componentes e/ou operações

library(lubridate)

year(dataNascmento1) # Extração por ano
month(dataNascmento1, label = T)  # Extração por mês com label = T
am(dataNascmento3) # Extração por período de horas

# sequência usando a ideia de intervalo de período por ano e por mês
(minhaSequencia <- seq(as.Date('2013-05-29'), as.Date('2021-06-26'), by = "year")) 
(minhaSequencia <- seq(as.Date('2013-05-29'), as.Date('2021-06-26'), by = "months"))



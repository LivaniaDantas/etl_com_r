
#Compartilhe com a gente um código criado por você com uma shadow matrix e um teste de aleatoriedade de valores ausentes.

library(data.table)
library(funModeling) 
library(tidyverse)



#Utilizando a base "Fligths data"

install.packages("nycflights13")
library(nycflights13)
data("flights")
status(flights)

banco <- flights
banco

## Shadow Matrix da base 

bancoNA <- as.data.frame(abs(is.na(banco))) # cria a matriz sombra da base de covid19

bancoNA<- bancoNA[which(sapply(bancoNA, sd) > 0)] # mantém variáveis com NA
round(cor(bancoNA), 3) # calcula correlações (arredondando as casas decimais)

# modificações
# trazendo uma variável de interesse (month) de volta para o frame
bancoNA <- cbind(bancoNA, month = banco$month) 

# sumarizando e observando a concentração dos NAs por mês
bancoNAMes <- bancoNA %>% group_by(month) %>% summarise(across(everything(), list(sum))) 
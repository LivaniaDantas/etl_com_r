####DATA TABLE
#Compartilhe com a gente um código criado por você com a aplicação direta do sumário de uma regressão linear, usando a sintaxe de data table.

library(data.table)
library(dplyr)
library(yarrr)

str(diamonds)

diamantesDT <- diamonds %>% setDT()
class(diamantesDT)

diamantesDT[ ,lm(formula = value ~ weight + clarity + color)]


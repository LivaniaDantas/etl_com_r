install.packages("funModeling")
install.packages("validate")
library(dplyr)
library(funModeling)
library(tidyverse)
library(data.table)
library(validate)

##DESCOBERTA
#Compartilhe com a gente um código em que você implementa EDA sobre uma base diferentes daquela do exercício.

#Utilizando a base de dados sinitros de trânsito da Prefeitura da Cidade do Recife de 2019

sinistrosRecife2019 <-fread("C:/R_Disciplina/eletiva_de_dados/etl_com_r/bases_originais/acidentes-2019.csv")

glimpse(sinistrosRecife2019) # olhada nos dados
glimpse(sinistrosRecife2019$vitimas) # Verifica uma única variável
status(sinistrosRecife2019) # estrutura dos dados (missing etc)
freq(sinistrosRecife2019) # frequência das variáveis fator
freq(sinistrosRecife2019$vitimas) #frequência das variáveis fator, selecionando variavel 
plot_num(sinistrosRecife2019) # exploração das variáveis numéricas
profiling_num(sinistrosRecife2019) # estatísticas das variáveis numéricas



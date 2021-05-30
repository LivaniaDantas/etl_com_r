##DESCOBERTA
#Compartilhe com a gente um código em que você implementa EDA sobre uma base diferentes daquela do exercício.

install.packages("funModeling")
library(funModeling)
library(tidyverse)
library(data.table)
library(dplyr)
install.packages("validate")
library(validate)

#Utilizando a base de dados trabalhada em exercícios anteriores: sinitros de trânsito da Prefeitura da Cidade do Recife de 2019 a 2021.

sinistrosRecife <-fread("C:/R_Disciplina/eletiva_de_dados/etl_com_r/bases_tratadas/sinistrosRecife.csv")


glimpse(sinistrosRecife) # olhada nos dados
glimpse(sinistrosRecife$bairro) # Verifica uma única variável
status(sinistrosRecife) # estrutura dos dados (missing etc)
freq(sinistrosRecife) # frequência das variáveis fator
freq(sinistrosRecife$bairro) # frequência das variáveis fator, selecionando uma única variavel 
plot_num(sinistrosRecife) # exploração das variáveis numéricas
profiling_num(sinistrosRecife) # estatísticas das variáveis numéricas

##ESTRUTURAÇÃO
#Compartilhe com a gente um código em que você implementa um pivô long to wide ou iwde to long

## Vetor identificando os bairros com alto índice de acidentes de trânsitos no Recife, observando a frquência acumulada de até 50,17.

bairros_indiceacidente_recife<-c("IMBIRIBEIRA", "SANTO AMARO", "BOA VISTA", "MADALENA",  "AFOGADOS",  "PINA", "DERBY", "BOA VIAGEM", "IPSEP", "CASA AMARELA", "CORDEIRO", "ESPINHEIRO")

# filtra casos apenas no vetor

bairros_acidentes<- sinistrosRecife %>% filter(bairro %in% bairros_indiceacidente_recife)

# cria matriz agrupando por bairro, criando uma nova linha com index e selecionando apenas algumas variáveis

mbairros <- bairros_acidentes %>% group_by(bairro) %>% mutate(row = row_number()) %>% select(bairro, tipo, row) 

# filtra dados para garantir que todos os bairros tenham mesmo nro de casos
result <- mbairros %>% group_by(bairro) %>% filter(row == max(row))
mbairros  <- mbairros %>% filter(row<=min(result$row)) 


# pivota o data frame de long para wide
mbairrosw <- mbairros %>% pivot_wider(names_from = row, values_from = tipo) %>% remove_rownames %>% column_to_rownames(var="bairro")

##LIMPEZA
#Compartilhe com a gente uma ampliação do código desta aula, em que você remove os NA (not available) presentes nos dados.

status(bairros_acidentes) # estrutura dos dados (missing etc)
freq(bairros_acidentes) # frequência das variáveis fator
plot_num(bairros_acidentes) # exploração das variáveis numéricas
profiling_num(bairros_acidentes) # estatísticas das variáveis numéricas

bairros_acidentes <- bairros_acidentes %>% select(natureza_acidente,num_semaforo,tipo)

status(bairros_acidentes) # estrutura dos dados (missing etc)
freq(bairros_acidentes) # frequência das variáveis fator
plot_num(bairros_acidentes) # exploração das variáveis numéricas
profiling_num(bairros_acidentes) # estatísticas das variáveis numéricas

bairros_acidentes %>% filter(situacao_semaforo < 0)



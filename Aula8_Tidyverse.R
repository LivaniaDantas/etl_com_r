#Instalando e chamando os pacotes
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

#############################################################

##ESTRUTURAÇÃO

#Compartilhe com a gente um código em que você implementa um pivô long to wide ou Wide to long

prepararBase <- function (base , ano)
{
  ## Vetor identificando os bairros com alto índice de acidentes de trânsitos no Recife. 
  
  bairros_indiceacidente_recife<-c("IMBIRIBEIRA", "SANTO AMARO", "BOA VISTA", "MADALENA",  "AFOGADOS",  "PINA", "DERBY", "BOA VIAGEM", "IPSEP", "CASA AMARELA", "CORDEIRO", "ESPINHEIRO")
  
  # filtra casos apenas no vetor
  
  sinistrosBairrosAcidentes<- base%>% filter(bairro %in% bairros_indiceacidente_recife)
  
  # cria matriz agrupando por bairro, criando uma nova linha com index e selecionando apenas algumas variáveis
  
  mbairros <- sinistrosBairrosAcidentes %>% group_by(bairro) %>% mutate(row = row_number()) %>% select(bairro, row) 
  
  mbairros$ano=paste("ano",ano, sep="_")
  
  # filtra dados para pegar somente a linha que tem o maior numero de acidentes por bairro
  sinistrosBairrosAcidentesAgregado <- mbairros %>% group_by(bairro) %>% filter(row == max(row))
  return(sinistrosBairrosAcidentesAgregado)
}

glimpse(sinistrosRecife2019) 
glimpse(sinistrosRecife2019$vitimas) 
status(sinistrosRecife2019) 
freq(sinistrosRecife2019) 
freq(sinistrosRecife2019$vitimas)  
plot_num(sinistrosRecife2019) 
profiling_num(sinistrosRecife2019) 


# pivotando o data frame de long para wide à partir da base preparada
sinistrosBairrosAcidentesAgregado2019 <- prepararBase(sinistrosRecife2019, 2019)

sinistrosBairrosAcidentesAgregado2019Wide <- sinistrosBairrosAcidentesAgregado2019 %>% pivot_wider(names_from = ano, values_from = row)
##################################################################

# LIMPEZA
# Compartilhe com a gente uma ampliação do código desta aula, em que você remove os NA (not available) presentes nos dados

# Verificando se há NA

status(sinistrosBairrosAcidentesAgregado2019Wide)

#Print do retorno
#        variable q_zeros p_zeros q_na p_na q_inf p_inf      type unique
#bairro     bairro       0       0    0    0     0     0 character     12
#ano_2019 ano_2019       

# Verificando se existe população negativa 
sinistrosBairrosAcidentesAgregado2019Wide %>% filter(ano_2019 < 0 ) 

# não há

#######################################################################
#ENRIQUECIMENTO
# Compartilhe com a gente uma aplicação de enriquecimento usando join em outra dupla de base
#Utilizando a base Sinistros Recife 2020 para demonstrar no data frame o número de acidentes ocorridos nos anos 2019 e 2020.

sinistrosRecife2020 <-fread("C:/R_Disciplina/eletiva_de_dados/etl_com_r/bases_originais/acidentes_2020.csv")

sinistrosBairrosAcidentesAgregado2020 <- prepararBase(sinistrosRecife2020, 2020)

glimpse(sinistrosRecife2020) 
glimpse(sinistrosRecife2020$vitimas) 
status(sinistrosRecife2020) 
freq(sinistrosRecife2020) 
freq(sinistrosRecife2020$vitimas)  
plot_num(sinistrosRecife2020) 
profiling_num(sinistrosRecife2020) 

sinistrosBairrosAcidentesAgregado2020Wide <- sinistrosBairrosAcidentesAgregado2020 %>% pivot_wider(names_from = ano, values_from = row)

sinistrosBairrosAcidentesAgregado2019e2020 <- left_join(sinistrosBairrosAcidentesAgregado2019Wide, sinistrosBairrosAcidentesAgregado2020Wide, by = c("bairro" = "bairro"))

#############################################################################
# VALIDAÇÃO
# Compartilhe com a gente uma aplicação de validação, com criação de regras pertinentes à base de dados que você estiver utilizando

#validar para garantir somente ter anos com + de 0 acidentes e informados

anosSemAcidentes <- validator(ano_2019 > 0, !is.na(ano_2019), ano_2020 > 0, !is.na(ano_2020))

validacaoAnosComAcidentes <- confront(sinistrosBairrosAcidentesAgregado2019e2020, anosSemAcidentes)

summary(validacaoAnosComAcidentes)

plot(validacaoAnosComAcidentes)

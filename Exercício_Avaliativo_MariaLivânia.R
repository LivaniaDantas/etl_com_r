#Exercício Avaliativo

library(data.table)
library(lubridate)
library(dplyr)
library(tidyverse)
library(readxl)
library(Hmisc)


#1. Extraia a base geral de covid em Pernambuco disponível neste endereço: https://dados.seplag.pe.gov.br/apps/corona_dados.html.

covidPE <- read.csv2("bases_originais/basegeral.csv", header = TRUE, sep = ';', encoding = 'UTF-8')

covidPEDT <- covidPE %>% setDT() #copiando a base covidPE usando data.table

#2. Calcule, para cada município do Estado, o total de casos confirmados e o total de óbitos por semana epidemiológica [atenção, você terá de criar uma variável de semana epidemiológica com base na data].

#Transformando em datas e factor
covidPEDT$dt_notificacao<-as.Date(covidPEDT$dt_notificacao, format = "%Y-%m-%d")
covidPEDT$dt_obito<-as.Date(covidPEDT$dt_obito, format = "%Y-%m-%d")

covidPEDT$obito<-ifelse(is.na(covidPEDT$dt_obito), 0, 1)
covidPEDT$casosConfirmado<-ifelse(covidPEDT$classe=="CONFIRMADO", 1, 0)
covidPEDT$notificacaoEpweek<-epiweek(covidPEDT$dt_notificacao)
covidPEDT$anoNotificacao<-year(covidPEDT$dt_notificacao)

covidPEDT$semanaEpidemiologicaObitos<-epiweek(covidPEDT$dt_obito)
covidPEDT$anoObitos<-year(covidPEDT$dt_obito)

bancoConfirmados <-covidPEDT %>% filter(confirmado==1 | obito==1) %>% group_by(municipio,anoNotificacao,notificacaoEpweek) %>% summarise(casosConfimado = sum(confirmado))

bancoObitos <-covidPEDT %>% filter(obito==1) %>% group_by(municipio,anoObitos,semanaEpidemiologicaObitos) %>% summarise(numeroMortos = sum(obito))

bancoFinal <- left_join(bancoConfirmados, bancoObitos, by = c('municipio' = 'municipio', 'anoNotificacao'='anoObitos', 'notificacaoEpweek'='semanaEpidemiologicaObitos'))


#3. Enriqueça a base criada no passo 2 com a população de cada município, usando a tabela6579 do sidra ibge.

bancoIbge <- read_xlsx("bases_originais/tabela6579.xlsx", col_names = FALSE, skip=5)

colnames(bancoIbge) <-c("municipio", "populacao")

bancoIbge$municipio<-str_to_upper(bancoIbge$municipio)
bancoFinal$municipio<- paste(bancoFinal$municipio, "(PE)")

bancoAgrupado <- left_join(bancoFinal, bancoIbge, by = c('municipio' = 'municipio'))

#4. Calcule a incidência (casos por 100.000 habitantes) e letalidade (óbitos por 100.000 habitantes) por município a cada semana epidemiológica.

bancoAgrupado$casos100000Hab<-bancoAgrupado$casosConfimado*100000/bancoAgrupado$populacao

bancoAgrupado$nMortosPor1000000<-bancoAgrupado$nMortos*100000/bancoAgrupado$populacao
summary(bancoAgrupado)




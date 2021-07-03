
#3º Exercício - Assuntos: transformações, textos e datas. 

#1. Extraia a base geral de covid em Pernambuco disponível neste endereço: https://dados.seplag.pe.gov.br/apps/corona_dados.html


covidPE <- read.csv2("bases_originais/basegeral.csv", header = TRUE, sep = ';', encoding = 'UTF-8')

library(funModeling)
library (tidyverse)
library(data.table)
library (Hmisc)

#Observando a base
glimpse(covidPE)
status (covidPE)
freq(covidPE$classe)

#2. Corrija os NAs da coluna sintomas através de imputação randômica


covidPEDT <- covidPE %>% setDT() #copiando a base covidPE usando data.table

covidPEDT$sintomas <- ifelse(covidPEDT$sintomas=="", NA, covidPEDT$sintomas)

(covidPEDT$sintomas <- impute(covidPEDT$sintomas, "random"))


#3. Calcule, para cada município do Estado, o total de casos confirmados e negativos

freq(covidPE$classe)
freq(covidPE$Resultado)

# cria matriz de Resultado dos Casos, agrupando por "municípios" e "classe", criando uma nova linha com index e selecionando a variável "classe"

casos <- c('CONFIRMADO', 'NEGATIVO')

totalCasos <- covidPEDT %>% select(municipio, classe) %>% group_by(municipio, classe) %>% count(classe) %>% filter (classe %in% casos)%>% pivot_wider(names_from = classe, values_from = n)

#4. Crie uma variável binária se o sintoma inclui tosse ou não e calcule quantos casos confirmados e negativos tiveram tosse como sintoma

covidPEDT <- covidPEDT %>% mutate (Tosse = ifelse(grepl("TOSSE", sintomas), "sim", "não"))
tosse <- "sim"
casosSintomas <- covidPEDT %>% select(municipio, classe, Tosse) %>% group_by(municipio, classe, Tosse) %>% count(classe) %>% filter (classe %in% casos) %>% filter (Tosse %in% tosse) %>% pivot_wider(names_from = classe, values_from = n)

#5. Agrupe os dados para o Estado, estime a média móvel de 7 dias de confirmados e negativos

library(zoo)

totalCasosAgrupados <- covidPEDT %>% select(classe, dt_notificacao) %>% group_by( classe, dt_notificacao) %>% count(classe) %>% filter (classe %in% casos) %>% pivot_wider(names_from = classe, values_from = n)

totalCasosAgrupados<-as.data.frame(totalCasosAgrupados)
mediaMovel <- totalCasosAgrupados  %>% mutate(confirmadosMM7 = round(rollmean(x = CONFIRMADO,  7, align = "right", fill = NA), 2)) # média móvel de 7 dias

mediaMovel<- mediaMovel %>% arrange(dt_notificacao)
mediaMovel <- mediaMovel  %>% mutate(negativosMM7 = round(rollmean(x = NEGATIVO,  7, align = "right", fill = NA), 2)) # média móvel de 7 dias


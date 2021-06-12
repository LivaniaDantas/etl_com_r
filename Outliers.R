###############Outliers
#Compartilhe com a gente um código criado por você usando uma das técnicas de identificação de outliers, mas no lugar da variável casos, busque em uma das outras duas variáveis ajustadas (casos2 ou casosLog)

library(dplyr)
library(data.table)
install.packages("plotly")
library(plotly)

#carregando os dados: Base covid19 Pernambuco
covid19PE <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv')


covid19PEMun <- covid19PE %>% count(municipio, sort = T, name = 'casos') %>% mutate(casos2 = sqrt(casos), casosLog = log10(casos))


# Identificação de outliers na variável 'casosLog', utilizando o Teste de Rosner

install.packages("EnvStats")
library(EnvStats)

(testeRosnerCovid19PE <- rosnerTest(covid19PEMun$casosLog, k = 10))

testeRosnerCovid19PE$all.stats

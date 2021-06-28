###Atividade_datas_na_pratica.R


url = 'https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv' 

#Passando a url para um objeto

# Baixando a base de covidBR
covidBR = read.csv2(url, encoding='latin1', sep = ',')

# Filtrando para o estado da Paraíba
covidPB <- subset(covidBR, state == 'PB')
str(covidPB)

# modificando a coluna data de string para date
covidPB$date <- as.Date(covidPB$date, format = "%Y-%m-%d")
str(covidPB) 

# criando um sequencial de dias de acordo com o total de datas para a predição
covidPB$dia <- seq(1:length(covidPB$date)) 

# criando um vetor auxiliar de predição
predDia = data.frame(dia = covidPB$dia) 

# criando segundo vetor auxiliar 
predSeq = data.frame(dia = seq(max(covidPB$dia)+1, max(covidPB$dia)+180))

# juntando os dois vetores criados 
predDia <- rbind(predDia, predSeq)

# pacote para predição
install.packages("drc")
library(drc)

# fazendo a predição log-log com a função drm (variável"newCases")

fitLL <- drm(newCases ~ dia, fct = LL2.5(),
             data = covidPB, robust = 'mean')

# observando o ajuste
plot(fitLL, log="", main = "Log logistic") 


predLL <- data.frame(predicao = ceiling(predict(fitLL, predDia))) # usando o modelo para prever para frente, com base no vetor predDia

predLL$data <- seq.Date(as.Date('2020-03-12'), by = 'day', length.out = length(predDia$dia)) # criando uma sequência de datas para corresponder aos dias extras na base de predição

predLL <- merge(predLL, covidPB, by.x ='data', by.y = 'date', all.x = T) # juntando as informações observadas da base original 

library(plotly) # biblioteca para visualização interativa de dados

# plotando tudo junto, para comparação
plot_ly(predLL) %>% add_trace(x = ~data, y = ~predicao, type = 'scatter', mode = 'lines', name = "Novos Casos - Predição") %>% add_trace(x = ~data, y = ~newCases, name = "Novos Casos - Observados", mode = 'lines') %>% layout(
  title = 'Predição de Novos Casos de COVID 19 na Paraíba', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Novos Casos por Dia', showgrid = FALSE),
  hovermode = "compare") 

library(zoo) # biblioteca para manipulação de datas e séries temporais

covidPB <- covidPB %>% mutate(newDeathsMM7 = round(rollmean(x = newDeaths, 7, align = "right", fill = NA), 2)) # média móvel de 7 dias

covidPB <- covidPB %>% mutate(newDeathsL7 = dplyr::lag(newDeaths, 7)) # valor defasado em 7 dias

# plotando tudo junto, para comparação
plot_ly(covidPB) %>% add_trace(x = ~date, y = ~newDeaths, type = 'scatter', mode = 'lines', name = "Novas Mortes") %>% add_trace(x = ~date, y = ~newDeathsMM7, name = "Novas Mortes MM7", mode = 'lines') %>% layout(
  title = 'Novas Mortes de COVID19 na Paraíba', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Novas Mortes por Dia', showgrid = FALSE),
  hovermode = "compare") 

install.packages("xts")
library(xts)

(covidPBTS <- xts(covidPB$newDeaths, covidPB$date)) # transformar em ST
str(covidPBTS)

autoplot(covidPBTS)
acf(covidPBTS)

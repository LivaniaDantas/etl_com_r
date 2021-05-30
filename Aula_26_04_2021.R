
sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')
glimpse(sinistrosRecife2020Raw)

sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')


sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')

glimpse(sinistrosRecife2019Raw)
View(sinistrosRecife2019Raw)

#Removendo da base de 2019 as colunas (variáveis): "endereço_cruzamento", "número_cruzamento", "referência_cruzamento".

sinistroRecife2019Modificada <- sinistrosRecife2019Raw[,c(1:9, 13:41)]
View(sinistroRecife2019Modificada)
names(sinistroRecife2019Modificada)[1] <- "data"
colnames(sinistroRecife2019Modificada)[1]
View(sinistroRecife2019Modificada)

# junta as bases de dados com comando rbind (juntas por linhas)

sinistrosRecifeRaw <- rbind(sinistroRecife2019Modificada,sinistrosRecife2020Raw, sinistrosRecife2021Raw)



# observa a estrutura dos dados
str(sinistrosRecife2019Raw)

library(dplyr)
glimpse(sinistrosRecifeRaw)
View(sinistrosRecifeRaw)

# modifca a data para formato date
sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw$data, format = "%Y-%m-%d")

glimpse(sinistrosRecifeRaw$data)

# modifica natureza do sinistro de texto para fator
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)

# cria funçaõ para substituir not available (na) por 0
naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

# aplica a função naZero a todas as colunas de contagem
sinistrosRecifeRaw[, 15:25] <- sapply(sinistrosRecifeRaw[, 15:25], naZero)

# exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")

###################################

###################################################################

# Desta vez, queremos que você mostre que entendeu o processo de ETL modificando um pouco a extração e o tratamento. Ou seja: adicione mais ano de acidentes de trânsito à extração e lembre-se de uni-lo aos demais com o rbind; depois, busque mais uma coluna para transformar em fator e acrescente isso ao código. Lembre-se de compartilhar um link do github!!!


sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')
glimpse(sinistrosRecife2020Raw)

sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

glimpse(sinistrosRecife2021Raw)

sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')

glimpse(sinistrosRecife2019Raw)
View(sinistrosRecife2019Raw)

#Retirando as colunas(variáveis) da base 2019: "endereço_cruzamento", "número_cruzamento", "referência_cruzamento", que não estam na base 2020 e 2021:

sinistroRecife2019Modificada <- sinistrosRecife2019Raw[,c(1:9, 13:41)]
View(sinistroRecife2019Modificada)

#Renomeando "DATA" na base 2019 para "data" 
names(sinistroRecife2019Modificada)[1] <- "data"
colnames(sinistroRecife2019Modificada)[1]
View(sinistroRecife2019Modificada)


# junta as bases de dados com comando rbind (juntas por linhas)

sinistrosRecifeRaw <- rbind(sinistroRecife2019Modificada,sinistrosRecife2020Raw, sinistrosRecife2021Raw)

# modifca a data para formato date
sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw$data, format = "%Y-%m-%d")
str(sinistrosRecifeRaw)

#Modificando formato de variáveis: Formato texto para fator


# modifica natureza do sinistro de texto para fator
sinistrosRecifeRaw$situacao <- as.factor(sinistrosRecifeRaw$situacao)
str(sinistrosRecifeRaw)

# cria funçaõ para substituir not available (na) por 0
naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

# aplica a função naZero a todas as colunas de contagem
sinistrosRecifeRaw[, 15:25] <- sapply(sinistrosRecifeRaw[, 15:25], naZero)

str(sinistrosRecifeRaw)

# exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")


  
#Desta vez, mostre que você entendeu o conceito de área intermediária e ambiente no R, modificando o código para manter sinistrosRecifeRaw e a função naZero (ela pode ser útil no futuro!). Além disso, indique qual dos objetos na área intermediária mais estavam usando memória do R. Lembre-se de compartilhar um link do github!!!


# vamos ver quanto cada objeto está ocupando



# ficamos com staging area??

ls() # lista todos os objetos no R

# vamos ver quanto cada objeto está ocupando

for (itm in ls()) { 
  print(formatC(c(itm, object.size(get(itm))), 
                format="d", 
                width=30), 
        quote=F)
}

ls() # lista todos os objetos no R
# agora, vamos remover

gc() # uso explícito do garbage collector

rm(list = c('sinistrosRecife2020Raw', 'sinistrosRecife2021Raw'))

# deletando todos os elementos: rm(list = ls())
# deletando todos os elementos, menos os listados: rm(list=(ls()[ls()!="sinistrosRecifeRaw"& ls()!="naZero"]))

saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")

ls()


#Desta vez, indique uma vantagem e uma desvantagem de cada tipo de arquivo (nativo e plano com interoperabilidade) e acrescente no código uma forma adicional de exportação e de leitura, com a respectiva comparação usando a função microbenchmark. Lembre-se de compartilhar um link do github!!!
  

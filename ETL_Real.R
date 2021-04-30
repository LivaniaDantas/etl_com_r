#Desta vez, queremos que você mostre que entendeu o processo de ETL modificando um pouco a extração e o tratamento. Ou seja: adicione mais ano de acidentes de trânsito à extração e lembre-se de uni-lo aos demais com o rbind; depois, busque mais uma coluna para transformar em fator e acrescente isso ao código. Lembre-se de compartilhar um link do github!!!

#Carregamento da base de sinitros de trânsito da Prefeitura de Cidade do Recife de 2019 a 2021

#Base2020
sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')

#Base2021
sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

#Base2019
sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')

str(sinistrosRecife2019Raw)


#Retirando as colunas(variáveis) da base 2019: "endereço_cruzamento", "número_cruzamento", "referência_cruzamento", que não consta na base de 2020 e de 2021:

sinistroRecife2019Modificada <- sinistrosRecife2019Raw[,c(1:9, 13:41)]


#Renomeando a coluna "DATA" na base 2019 para "data" 
names(sinistroRecife2019Modificada)[1] <- "data"
colnames(sinistroRecife2019Modificada)[1]



# Juntando as bases 2019,2020 e 2021 com o comando "rbind"

sinistrosRecifeRaw <- rbind(sinistroRecife2019Modificada,sinistrosRecife2020Raw, sinistrosRecife2021Raw)

str(sinistrosRecifeRaw)

# Modificando  a data para formato date
sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw$data, format = "%Y-%m-%d")
str(sinistrosRecifeRaw)

#Modificando o formato da variável "situação" que está no formato texto para factor

sinistrosRecifeRaw$situacao <- as.factor(sinistrosRecifeRaw$situacao)


# Criação da função para substituir os not available (NA) por 0
naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

# Aplicando a função naZero a todas as colunas de contagem
sinistrosRecifeRaw[, 15:25] <- sapply(sinistrosRecifeRaw[, 15:25], naZero)

str(sinistrosRecifeRaw)

#Exportação das bases tratadas no formato nativo do R (RDS)
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

#Exportação das bases tratadas no formatoo tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")

######################################################



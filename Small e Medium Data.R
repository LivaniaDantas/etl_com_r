
library(data.table)

enderecoBase <- 'bases_originais/despesas_contratadas_candidatos_2020_BRASIL.csv'

# extração direta via read.csv
system.time(extracaoLD1 <- read.csv2(enderecoBase))

#Resultado da eficiência
#usuário   sistema decorrido 
#141.42     11.98    164.07 

# extração via amostragem com read.csv

# ler apenas as primeiras 20 linhas
amostraLD1 <- read.csv2(enderecoBase, nrows=20)

amostraLD1Classes <- sapply(amostraLD1, class) # encontra a classe da amostra amostra

# fazemos a leitura passando as classes de antemão, a partir da amostra
system.time(extracaoLD2 <- data.frame(read.csv2("bases_originais/largeData.csv", colClasses=amostraLD1Classes) ) ) 

#Resultado da eficiência
# usuário   sistema decorrido 
#108.51      8.89    127.84 

# extração via função fread, que já faz amostragem automaticamente
system.time(extracaoLD3 <- fread(enderecoBase))

#usuário   sistema decorrido 
#67.95     13.07    110.32 

###

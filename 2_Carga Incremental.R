#Compartilhe com a gente um código criado por você utilizando um dos três métodos em um conjunto de dados diferente daquele do exercício. Lembre-se de compartilhar um link do github!!!

library(dplyr)


#Registro das solicitações e serviços do dia atual, em tempo Real.
#Dados das demandas de serviços de arborização, Drenagem, Iluminação, Limpeza, Pavimentação, tapa buracos, entre outros serviços de reparação da Cidade do Recife, solicitados pelo cidadão através do telefone 156 ou via atendimento online através do aplicativo Conecta Recife

# carrega base de dados original
chamadosEmlurbTempoReal <- read.csv2('http://dados.recife.pe.gov.br/dataset/99eea78a-1bd9-4b87-95b8-7e7bae8f64d4/resource/9afa68cf-7fd9-4735-b157-e23da873fef7/download/156_diario.csv', sep = ';', encoding = 'UTF-8')

# carrega base de dados para atualização
chamadosEmlurbTempoRealNew <- read.csv2('http://dados.recife.pe.gov.br/dataset/99eea78a-1bd9-4b87-95b8-7e7bae8f64d4/resource/9afa68cf-7fd9-4735-b157-e23da873fef7/download/156_diario.csv', sep = ';', encoding = 'UTF-8')


# compara usando a chave primária
chamadosEmlurbTempoRealIncremento <- (!chamadosEmlurbTempoRealNew$LOGRADOURO %in% chamadosEmlurbTempoReal$LOGRADOURO)

# cria base de comparação
chamadosEmlurbTempoRealIncremento <- (!chamadosTempoRealNew$chaveSubstituta %in% chamadosTempoReal$chaveSubstituta)

# comparação linha a linha
setdiff(chamadosEmlurbTempoRealNew, chamadosEmlurbTempoReal)


# retorna vetor com incremento
nrow(chamadosEmlurbTempoReal[chamadosEmlurbTempoRealIncremento,])

# junta base original e incremento
chamadosEmlurbTempoReal <- rbind(chamadosEmlurbTempoReal, chamadosEmlurbTempoReal[chamadosEmlurbTempoRealIncremento,])


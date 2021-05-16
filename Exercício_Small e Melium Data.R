
library(data.table)

#Criando um dado volumoso (large data)

casos= 2e7

# criando o data.frame com o total de casos definido acima
largeData = data.table(a=rpois(casos, 3),
                       b=rbinom(casos, 1, 0.7),
                       c=rnorm(casos),
                       d=sample(c("básico","fundamental","médio","superior"), casos, replace=TRUE),
                       e=rnorm(casos),
                       f=rpois(casos, 4),
                       g=rnorm(casos)
)

# função para retornar o tamanho do objeto
object.size(largeData) 

# Verificar as primeiras linhas
head(largeData)

# Salvando a base no disco
write.table(largeData,"bases_originais/largeData.csv",sep=",",row.names=FALSE,quote=FALSE) 

#Compartilhe com a gente um código criado por você em que você usa um dos dois processos otimizados (read.csv2 com amostragem ou fread) para ler uma base de dados ampla! Também compartilhe prints, mostrando a eficiência de cada caso. Mas lembre-se de conferir se a interpretação das colunas está de acordo, hein??? Não adiante puxar os dados com eficiência e perder eficácia, criando anomalias!

enderecoBase <- 'bases_originais/largeData.csv'

# extração direta via read.csv
system.time(extracaoDireta <- read.csv2(enderecoBase))

#Print do Retorno
# usuário   sistema decorrido 
#  42.67      3.72     96.69

str (extracaoDireta)


# extração via função fread, que já faz amostragem automaticamente
system.time(extracaoOtimizada <- fread(enderecoBase))

#Print do Retorno
#usuário   sistema decorrido 
# 5.95      3.28    127.77 

str (extracaoOtimizada)


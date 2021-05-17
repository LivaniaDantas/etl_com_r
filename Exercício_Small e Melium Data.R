
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
############################################
#Compartilhe com a gente um código criado por você em que um large data é lido através da função ff. Também mostre pelo menos duas operações estatísticas (média, mediana...) ou matemáticas básicas (soma, produto...), e uma aplicação de estatística inferencial (regressão linear, X²...), usando uma amostra da base

library(ff)
install.packages("ffbase")
library(ffbase)


# criando o arquivo ff
system.time(extracaoff <- read.csv.ffdf(file=enderecoBase))

#Print do Retorno
# usuário   sistema decorrido 
#  57.55      8.81    144.42 

# Verificando a classe do objeto
class(extracaoff) 

#Print do Retorno
#[1] "ffdf"

# Verificando o tamanho
object.size(extracaoff) 

#Print do Retorno
#28520 bytes

#Operações Estatísticas
mean(extracaoff[,2]) 

#Print do Retorno
#[1] 0.7000566

median(extracaoff[,2]) 
#Print do Retorno
#[1] 1

# Regressão a partir de uma amostra
extracaoffAmostra <- extracaoff[sample(nrow(extracaoff), 100000) , ]

head(extracaoffAmostra)

regressao <- lm(a ~ b + f, data=extracaoffAmostra)
summary (regressao)

#Print do Retorno da Regressão
#Residuals:
#  Min      1Q  Median      3Q     Max 
#-3.0440 -1.0023 -0.0016  1.0070 11.0023 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept) 2.9783780  0.0148766 200.205   <2e-16 ***
# b           0.0007425  0.0119861   0.062   0.9506    
# f           0.0046369  0.0027361   1.695   0.0901 .  
#---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 1.736 on 99997 degrees of freedom
#Multiple R-squared:  2.875e-05,	Adjusted R-squared:  8.754e-06 
#F-statistic: 1.438 on 2 and 99997 DF,  p-value: 0.2375

tarefaSemente  <- addTaskCallback (function( ... ) {set.seed( 123); TRUE}) # atribui a tarefa à variável tarefaSemente
tarefaSemente  # chama a tarefaSemente

#Simulação de uma distribuição normal para 200 casos
distNormalSimulacao <-rnorm(200)
distNormalSimulacao

summary(distNormalSimulacao)

#Simulação de uma distribuição binomial

#40 Atendimento em um período de 30 dias em um determinado PSF, com probabilidade de diagnóstico de Hipertensão de 0.25

distBinomialSimulacao <- rbinom(30, 40, 0.25)
distBinomialSimulacao 

#Indexação com a função seq e lenght
indexdistNormalSimulacao  <- seq (1, length(distrtNormalSimulacao)/3)

indexdistNormalSimulacao

removeTaskCallback (tarefaSemente)

##############################################
#Exercicio Amostragem e Bootstrapping 

sample(distNormalSimulacao, 15, replace = FALSE)
# ciando um bootstraping com a função replicate
set.seed(412) 

bootsNormal <- replicate(25, sample(distNormalSimulacao, 15, replace = TRUE)) # replicando 25x a amostra de 15 casos
bootsNormal


#calculando media com Bootstrapping
mediaBootsNormal25 <-replicate(25, mean(sample(distNormalSimulacao, 15, replace = TRUE)))
mediaBootsNormal25

mediaBootsNormal75 <-replicate(75, mean(sample(distNormalSimulacao, 15, replace = TRUE)))
mediaBootsNormal75

mediaBootsNormal100 <-replicate(100, mean(sample(distNormalSimulacao, 15, replace = TRUE)))
mediaBootsNormal100

#comparando medias
mean(mediaBootsNormal25)  # media do boostraping 25
mean(mediaBootsNormal75)  # media do boostraping 75
mean(mediaBootsNormal100) # media do boostraping 100
mean(distNormalSimulacao) # media dos dados originais










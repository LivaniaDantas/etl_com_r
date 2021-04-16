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

#################################



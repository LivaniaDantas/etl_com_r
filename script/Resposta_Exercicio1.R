# ###########Primeiro_Exercicio (Exercicio 1)
# 
# 1. Crie um data frame com pelo menos 500 casos e a seguinte composição: duas variáveis normais de desvio padrão diferente, uma variável de contagem (poisson), uma variável de contagem com dispersão (binomial negativa), uma variável binomial (0,1), uma variável qualitativa que apresenta um valor quando a variável binomial é 0 e outro quando é 1, e uma variável de index. 

# 
tarefaSemente <- addTaskCallback(function(...) {set.seed(123);TRUE}) # atribui a tarefa à variável tarefaSemeente
tarefaSemente # chama a tarefaSement

normal1 <- rnorm(500, mean = 0, sd = 3)
normal1

normal2 <- rnorm(500, mean = 0, sd = 6)
normal2

#uma variável de contagem (poisson)
poisson <- rpois (500, 7)
poisson

#uma variável de contagem com dispersão (binomial negativa)

binomialNegativa <- rnbinom(500, mu = 7, size = 10)
binomialNegativa

#uma variável binomial (0,1)

binomial <- rbinom(500, 1, 0.7)
binomial

# uma variável qualitativa que apresenta um valor quando a variável binomial é 0 e outro quando é 1

binomialAlterada <- binomial
binomialAlterada

binomialCategorizada <- ifelse(binomialAlterada == 1, "certo", "errado")
binomialCategorizada

#variável de index

indexNormal1 <- seq(1, length(normal1))
indexNormal1

#Data Frame
bancoOriginal<- data.frame(normal1, normal2, poisson, binomialNegativa, binomial, binomialCategorizada, indexNormal1)

bancoOriginal
str(bancoOriginal)
View(bancoOriginal)
   
# 2. Centralize as variáveis normais. 


normal1Centralizada <- normal1 - mean(normal1)
normal1Centralizada

hist(normal1)
hist(normal1Centralizada)

normal2Centralizada <- normal2 - mean(normal2)
normal2Centralizada

hist(normal2)
hist(normal2Centralizada)

# 3. Troque os zeros (0) por um (1) nas variáveis de contagem. 

banco1 <-bancoOriginal
banco1
str(banco1)

for(i in 3:4)#para i variando entre 3 e 4 
{
  for (j in 1:length(banco1[, i]))#para j variando entre 1 e o numero de linhas da coluna i
  {
    if(banco1[j,i] == 0)
    {
      banco1[j, i] <- 1
    }
  }
  
}


####Testando a alteração
bancoOriginal[74, 3]
banco1[74, 3]

bancoOriginal[478, 3]
banco1[478, 3]

bancoOriginal[334, 4]
banco1[334, 4]


  
# 4. Crie um novo data.frame com amostra (100 casos) da base de dados original.

bancoAmostra <- bancoOriginal[sample(nrow(bancoOriginal), 100, r = T), ]
bancoAmostra
View(bancoAmostra)



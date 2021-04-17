###############Usando Indexação

###Pacote Mtcars

bancoMtcars <- mtcars

glimpse(bancoMtcars)

str(bancoMtcars)

bancoMtcars$cyl  #Observando a coluna cyl

bancoMtcars[ ,1]  #Seleção da linha 1

bancoMtcars[1]  #Seleção da linha

bancoMtcars[2, c(1:5)]  #Seleção do segundo elemento das colunas de 1 a 5

bancoMtcars$cyl  #Seleção da coluna cyl

bancoMtcars [ , 1:3] #seleção de todas as linhas das colunas 1 a 3

which(bancoMtcars$cyl<= 4) # seleção das linhas de carros com com até 4 cilindradas

bancoMtcars[, 'mpg', drop = FALSE] # seleção da coluna mpg, indexada pelo nome, em formato de coluna


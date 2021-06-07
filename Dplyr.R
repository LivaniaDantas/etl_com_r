####Dplyr
#Compartilhe com a gente um código criado por você com a aplicação de pelo menos um sumário, um agrupamento, uma manipulação de casos e uma manipulação de colunas.

library(dplyr)
library(yarrr)
str(diamonds)

# sumários
count(diamonds, color) 

# sumários com agrupamentos
diamonds %>% group_by(color) %>% summarise(avg = mean(value))

# manipulação de casos
# ordenar casos
arrange(diamonds, value) # ascendente
arrange(diamonds, desc(value)) # descendente

# seleção de colunas
diamonds %>% select(value, weight, clarity) %>% arrange(clarity)

#criação de uma nova coluna
diamonds %>% mutate(preçoMédio = value/weight)



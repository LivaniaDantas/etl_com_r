# criação de um vetor numerico com num_ímpares

num_impares <- c(1,3,5,7,9)

# criação de um vetor texto com dias da semana

dias_semana <- c("segunda-feira", "terça-feira", "quarta-feira", "quinta-feira", "sexta-feira")


# Instalação do pacote yarrr
install.packages('yarrr')

# Carregar pacote
library(yarrr)

#Pacote_yarrr, base_diamonds.
#Estimação do valor de cada diamante (DV = value) com uma combinação linear de três variáveis independentes: peso, clareza e cor. 

diamonds.lm <- lm(formula = value ~ weight + clarity + color,
                  data = diamonds)
summary(diamonds.lm)

#Aplicação do exemplo demonstrado pelo professor.

diamonds.lm <- lm(value ~ .,diamonds)
summary(diamonds.lm)


str(diamonds.lm)

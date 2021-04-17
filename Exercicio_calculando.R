
#Centralizando a base mtcars com duas variáveis mpg e cyl
library(tidyverse)

banco <- mtcars
novaMtcars <- banco %>% 
  select(mpg, cyl)

glimpse(novaMtcars)

novaMtcarsCentral <- novaMtcars$mpg - mean(novaMtcars$mpg)
hist(novaMtcars$mpg)
hist(novaMtcarsCentral)

novaMtcarsCentral <- novaMtcars$cyl - mean(novaMtcars$cyl)
hist(novaMtcars$cyl)
hist(novaMtcarsCentral)
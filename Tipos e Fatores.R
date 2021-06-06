####TIPOS E FATORES

#Compartilhe com a gente um código em que vocês cria uma estrutura de fatores.

nivelInstrucao <- c(1,2,2,3,0,4,1,1,3,3)
recode <- c(Fundamental1 = 1, Fundamental2 = 2, Médio = 3, Superior = 4)
(nivelInstrucao <- factor(nivelInstrucao, levels = recode, labels = names(recode)))

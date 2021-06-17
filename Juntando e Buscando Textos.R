#Compartilhe com a gente um código criado por você em que você junta duas bases por nomes não categorizados e, em seguida, realiza uma busca por determinados textos em uma das colunas. Atenção: a base de dados pode ser simulada! não precisa ser real.


#Criando as bases simuladas

cursos <- c("Administração", "Ciências Contábeis", "Medicina", "Direito", "Engenharia Agrônomica", "Letras")

turno <- c("manhã", "tarde", "integral", "noite", "tarde", "noite" ) 

vagas <- c(40, 50, 35, 50, 40, 50 )

docentes <- c(15, 10, 12, 20, 18, 17)

baseCursos <- data.frame(cursos, turno, vagas, docentes)


baseMatriculados <- data.frame(cursos = c("Administracao", "Ciência contábeis", "Meddicina", "Direito", "Engenharia agronomica", "Letras"), 
                              AlunosMatriculados = c(42, 40, 35, 38, 40, 47),
                              Situação = c("Ultrapassou as vagas", "Há vagas", "Completou as vagas", "Há vagas", "Completou as vagas", "Há vagas" ))


#Junção das duas bases por nomes não categorizados

library(fuzzyjoin)

basesJuntas <- stringdist_join(baseCursos, baseMatriculados, mode='left')


#Criando uma nova base acrescentando a coluna "Período" com o resultado da busca por texto realizada na coluna "turno".

library(dplyr)

diurno <- c("manhã", "tarde", "integral")

basesJuntasP <- basesJuntas %>% mutate(Período = ifelse(grepl(paste(diurno, collapse="|"), turno), 'DIURNO', 'NOTURNO'))





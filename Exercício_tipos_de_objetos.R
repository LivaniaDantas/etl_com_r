install.packages("eeptools")
library("eeptools")

#Vetor com nome das escolas particulares de Serra Talhada-PE

nomeEscolas <- c("CFM", "Literato", "Nova Geração", "CIM")
nomeEscolas

#Vetor ano de fundação da escola
anoFundacao <- as.Date(c("1989-05-20", "2015-03-08", "1999-06-16", "1970-11-30"))


#Vetor com tempo de fundação da escola
tempoFundacao <-round( age_calc(anoFundacao, units = 'years'))


#Vetor com o bairro onde a escola está localizada
bairroEscolas <- c("AABB", "AABB", "Nossa Sra da Penha", "Nossa Sra da Penha") 
bairroEscolas

#Quantidade de alunos matriculados
alunosMatriculados <- c(350, 200, 280, 420)
alunosMatriculados

#Vetor com o número de funcionários que exercem a função de Professor
professor <- c(18, 12, 15, 25)
professor

#Vetor com o número de funcionários administrativos
pessoalAdministrativo <- c(6, 4, 7, 10)
pessoalAdministrativo

#dataframe com os dados das escolas particulares de Serra Talhada-PE

escolasParticularesSerraTalhada <- data.frame(nomeEscolas, bairroEscolas, tempoFundacao, 
                                              alunosMatriculados, professor,
                                              pessoalAdministrativo)
escolasParticularesSerraTalhada

                                              
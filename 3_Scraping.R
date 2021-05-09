#Compartilhe com a gente um código em que você faz o scrap de alguma página, criando um data.frame. Lembre-se de compartilhar um link do github!!!

library(rvest)
library(dplyr)

# tabelas da wikipedia
url <- "https://pt.wikipedia.org/wiki/%C3%8Dndice_de_massa_corporal"

urlTables <- url %>% read_html %>% html_nodes("table")
urlTables

consultaImc <- as.data.frame(html_table(urlTables[3]))

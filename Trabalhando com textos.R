#Compartilhe com a gente um código criado por você em que você carrega para o R um pdf que tenha alguma data; em seguida, troca as barras "/" das datas por hífens "-", e, por fim, faz a extração das datas usando esse novo padrão.

install.packages("textreadr")
library(textreadr)
library(pdftools)
install.packages("stringr")
library (stringr)

# Carregando o pdf
documentoPDF <- read_pdf('documentos/Pagamentos_2020.pdf', ocr = T)

# modifica as barras "/" das datas por hífens "-"

datasModificadas <- str_replace_all (string = documentoPDF, pattern = "/", replacement = "-") 


#extração das datas com o padrão modificado


( datas <- str_extract_all(datasModificadas, "\\d{2}-\\d{2}-\\d{4}"))

  
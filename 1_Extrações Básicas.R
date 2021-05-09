#Compartilhe com a gente um código criado por você extraindo dados de pelos menos 3 dessas 5 fontes. Lembre-se de compartilhar um link do github!!!
  


# arquivos csv

arvoresTombadasRecife <- read.csv2('http://dados.recife.pe.gov.br/dataset/54b30ac0-197b-4ad9-824c-854a220ad46c/resource/0c1935f4-1a7f-4c76-b3ba-b344951d6820/download/arvores-tombadas.csv', sep = ';', encoding = 'UTF-8')



# arquivos xml
install.packages('XML')
library(XML)

dadosLeilaoYahoo <- xmlToDataFrame("http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/auctions/yahoo.xml")

# arquivos json
install.packages('rjson')
library(rjson)

metadadosReceita <- fromJSON(file= "http://dados.recife.pe.gov.br/dataset/b0653677-2153-4085-829d-3f61540491eb/resource/7fb0ab90-92ad-45a5-927d-8e999c033561/download/metadados-receitas.json")

metadadosReceita <- as.data.frame(metadadosReceita)



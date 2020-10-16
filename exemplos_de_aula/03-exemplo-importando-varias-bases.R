# Na pasta "dados/por_ano/" temos a base IMDB com cada ano em um arquivo.
# Não é raro recebermos bases com essa configuração. O trabalho que teríamos
# para empilhar todas as bases manualmente seria imenso, ainda bem que com o
# R conseguimos fazer isso com apenas algumas linhas de código.
#
# Nesta atividade:
#
# 1. Leia a seção 3.12 do livro da Curso-R sobre Controle de fluxos:
# https://livro.curso-r.com/3-12-controle-de-fluxo.html
#
# 2. Construa um script em R para ler em empilhar as bases contidas na
# pasta dados/por_ano/ no material do curso.
#
# Dicas:
#
# - Você vai precisar usar um for.
# - Use a função list.files() para pegar o nome de todos os arquivos de uma pasta.
# - Use a função rbind() para empilhar bases.

arquivos <- list.files("dados/por_ano/", full.names = TRUE)

imdb <- readr::read_rds(arquivos[1])

for(arq in arquivo[-1]) {
  imdb <- rbind(imdb, readr::read_rds(arq))
}

# arquivos_novos <- arquivos[-1]

# for(i in 1:89) {
#   imdb <- rbind(imdb, readr::read_rds(arquivos_novos[i]))
# }

# for(arq in arquivos_novos) {
#   imdb <- rbind(imdb, readr::read_rds(arq))
# }

# for(i in 2:90) {
#   imdb <- rbind(imdb, readr::read_rds(arquivos[i]))
# }


for(arq in arquivos) {
  if(arq == arquivos[1]) {
    imdb <- readr::read_rds(arq)
  } else {
    imdb <- rbind(imdb, readr::read_rds(arq))
  }
}

#####
# Fazendo usando o purrr::map()

arquivos <- list.files("dados/por_ano/", full.names = TRUE)

imdb <- purrr::map_dfr(arquivos, readr::read_rds)

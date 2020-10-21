# Pacotes -----------------------------------------------------------------

library(tidyverse)

library(dplyr)

# Base de dados -----------------------------------------------------------

imdb <- readr::read_rds("dados/imdb.rds")

# Jeito de ver a base -----------------------------------------------------

dplyr::glimpse(imdb)
names(imdb)
View(imdb)

# dplyr: 6 verbos principais
# select()    # seleciona colunas do data.frame
# filter()    # filtra linhas do data.frame
# arrange()   # reordena as linhas do data.frame
# mutate()    # cria novas colunas no data.frame (ou atualiza as colunas existentes)
# summarise() + group_by() # sumariza o data.frame
# left_join   # junta dois data.frames

# select ------------------------------------------------------------------

# Selcionando uma coluna da base

select(imdb, titulo)

imdb_titulo <- select(imdb, titulo)

# imdb <- select(imdb, titulo)

# A operação NÃO MODIFICA O OBJETO imdb

imdb

# Selecionando várias colunas

select(imdb, titulo, ano, orcamento)

select(imdb, titulo:cor)

# Funções auxiliares

select(imdb, ator_1, ator_2, ator_3)

select(imdb, ator_1:ator_3)

select(imdb, starts_with("ator"))
select(imdb, contains("to"))

relocate()
select(imdb, ano, everything())

# Principais funções auxiliares

# starts_with(): para colunas que começam com um texto padrão
# ends_with(): para colunas que terminam com um texto padrão
# contains():  para colunas que contêm um texto padrão

# Selecionando colunas por exclusão

select(imdb, -starts_with("ator"), -titulo, - ends_with("s"))

select(imdb, -starts_with("ator"), -titulo, -ends_with("s"))


# Exercícios --------------------------------------------------------------

# 1. Crie uma tabela com apenas as colunas titulo, diretor,
# e orcamento. Salve em um objeto chamado imdb_simples.

imdb_simples <- select(imdb, titulo, diretor, orcamento)
imdb_simples

# 2. Selecione apenas as colunas ator_1, ator_2 e ator_3 usando
# o ajudante contains().

select(imdb, contains("ator_"))

# arrange -----------------------------------------------------------------

# Ordenando linhas de forma crescente de acordo com
# os valores de uma coluna

View(arrange(imdb, orcamento))

imdb_ord <- arrange(imdb, orcamento)

# imdb <- arrange(imdb, orcamento)

# Agora de forma decrescente

View(arrange(imdb, desc(orcamento)))

# Ordenando de acordo com os valores
# de duas colunas

View(arrange(imdb, desc(ano), orcamento))

# O que acontece com o NA?

df <- tibble(x = c(NA, 2, 1), y = c(1, 2, 3))
arrange(df, x)
arrange(df, desc(x))


# Exercícios --------------------------------------------------------------

# 1. Ordene os filmes em ordem crescente de ano e
# decrescente de receita e salve em um objeto
# chamado filmes_ordenados.

filmes_ordenados <- arrange(imdb, ano, desc(receita))

# 2. Selecione apenas as colunas título e orçamento
# e então ordene de forma decrescente pelo orçamento.
# Salve essa tabela em um objeto.

imdb_select_arrange <- arrange(select(imdb, titulo, orcamento), desc(orcamento))

imdb_select <- select(imdb, titulo, orcamento)
imdb_arrange <- arrange(imdb_select, desc(orcamento))

# Pipe (%>%) --------------------------------------------------------------

# Transforma funções aninhadas em funções
# sequenciais

# g(f(x)) = x %>% f() %>% g()

x %>% f() %>% g()   # CERTO
x %>% f(x) %>% g(x) # ERRADO

# Receita de bolo sem pipe.
# Tente entender o que é preciso fazer.

esfrie(
  asse(
    coloque(
      bata(
        acrescente(
          recipiente(
            rep(
              "farinha",
              2
            ),
            "água", "fermento", "leite", "óleo"
          ),
          "farinha", até = "macio"
        ),
        duração = "3min"
      ),
      lugar = "forma", tipo = "grande", untada = TRUE
    ),
    duração = "50min"
  ),
  "geladeira", "20min"
)

# Veja como o código acima pode ser reescrito
# utilizando-se o pipe.
# Agora realmente se parece com uma receita de bolo.

recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo") %>%
  acrescente("farinha", até = "macio") %>%
  bata(duração = "3min") %>%
  coloque(lugar = "forma", tipo = "grande", untada = TRUE) %>%
  asse(duração = "50min") %>%
  esfrie("geladeira", "20min")

# ATALHO DO %>%: CTRL (command) + SHIFT + M

# Exercício ---------------------------------------------------------------

# Refaça o exercício 2 do arrange utilizando o %>%.
# 2. Selecione apenas as colunas título e orçamento
# e então ordene de forma decrescente pelo orçamento.

imdb_select_arrange <- arrange(select(imdb, titulo, orcamento), desc(orcamento))

imdb_select <- select(imdb, titulo, orcamento)
imdb_arrange <- arrange(imdb_select, desc(orcamento))

imdb_select_arrange <- imdb %>%
  select(titulo, orcamento) %>%
  arrange(desc(orcamento))

imdb$titulo
select(imdb, titulo)

# filter ------------------------------------------------------------------

sum(c(1, 2, 3)) %>% sqrt()

c(1, 2, 3) %>% sum() %>% sqrt()
sum(c(1, 2, 3))

# Filtrando uma coluna da base

View(filter(imdb, nota_imdb > 9))

imdb %>% filter(nota_imdb > 9) %>% View

imdb_filtrada <- imdb %>%
  filter(nota_imdb > 9)

# imdb %>% filter(nota_imdb > 9) -> imdb_filtrada

# data.frame, base, tibble, dados, tabela: sinonimos
# variável, coluna: sinonimos

imdb %>% filter(diretor == "Quentin Tarantino")

sum()
mean()
median()
dp()
var()

# Vendo categorias de uma variável
unique(imdb$cor) # saída é um vetor
imdb %>% distinct(cor) # saída é uma tibble

# Filtrando duas colunas da base

## Recentes e com nota alta
imdb %>% filter(ano > 2010, nota_imdb > 8.5) %>% View()
imdb %>% filter(ano > 2010 && nota_imdb > 8.5)

## Gastaram menos de 100 mil, faturaram mais de 1 milhão
imdb %>% filter(orcamento < 100000, receita > 1000000)

## Lucraram
imdb %>% filter(receita - orcamento > 0)

## Lucraram mais de 500 milhões OU têm nota muito alta
imdb %>% filter(receita - orcamento > 500000000 | nota_imdb > 9) %>% View

# O operador %in%
imdb %>% filter(ator_1 %in% c('Angelina Jolie Pitt', "Brad Pitt")) %>% View
imdb %>% filter(ator_1 == 'Angelina Jolie Pitt' | ator_1 == "Brad Pitt") %>% View

pitts <- c('Angelina Jolie Pitt', "Brad Pitt")

vetor_de_atores <- imdb$ator_2

imdb %>% filter(ator_1 %in% vetor_de_atores)

imdb %>% filter(ator_1 %in% pitts & ator_2 %in% pitts) %>% View

# Negação
imdb %>% filter(diretor %in% c("Quentin Tarantino", "Steven Spielberg"))
imdb %>% filter(!diretor %in% c("Quentin Tarantino", "Steven Spielberg"))


# O que acontece com o NA?
df <- tibble(x = c(1, NA, 3))

filter(df, x > 1)
filter(df, x > 1 | is.na(x))

filter(df, is.na(x) | x > 1)

df %>% filter(!is.na(x))

# Filtrando texto sem correspondência exata
# A função stringr::str_detect()
textos <- c("a", "aa","abc", "bc", "A", NA)

# string, texto, conjunto de caracteres: sinônimos

stringr::str_detect(textos, pattern = "a")

## Pegando os seis primeiros valores da coluna "generos"
imdb$generos[1:6]

# Jeito dplyr
# imdb %>%
#   select(generos) %>%
#   slice(1:6)

stringr::str_detect(
  string = imdb$generos[1:6],
  pattern = "Action"
)

imdb %>% select(generos)

imdb %>% filter(generos == "Action")

imdb %>% filter(`==`(generos, "Action"))

## Pegando apenas os filmes que
## tenham o gênero ação
imdb %>% filter(generos == "Action") %>% View()
imdb %>% filter(stringr::str_detect(generos, "Action")) %>% View()

imdb %>% filter(stringr::str_detect(generos, "Action") |
                  stringr::str_detect(generos, "Sci-Fi")) %>%
  View()

imdb %>% filter(stringr::str_detect(generos, "Action"))

# Exercícios --------------------------------------------------------------

# 1. Criar um objeto chamado `filmes_pb` apenas com filmes
# preto e branco. (==)
# dica: use unique(), count(), distinct() ou table() pra descobrir como que "preto e branco"
# está representado na tabela.

unique(imdb$cor)

filmes_pb <- imdb %>% filter(cor == "Black and White") %>% tibble::view()

# 2. Criar um objeto chamado curtos_legais com filmes
# de 90 minutos ou menos de duração e nota no imdb maior do que 8.5.

curtos_legais <- imdb %>%
  filter(duracao <= 90, nota_imdb > 8.5) %>%
  tibble::view()

# mutate ------------------------------------------------------------------

# Modificando uma coluna

imdb %>%
  mutate(duracao = duracao / 60) %>%
  View()

# Criando uma nova coluna

imdb %>%
  mutate(duracao_horas = duracao/60) %>%
  View()

imdb %>%
  mutate(lucro = receita - orcamento) %>%
  View()

# A função ifelse é uma ótima ferramenta
# para fazermos classificação binária

imdb %>% mutate(
  lucro = receita - orcamento,
  houve_lucro = ifelse(lucro > 0, "Sim", "Não")
) %>%
  select(receita, orcamento, lucro, houve_lucro) %>%
  View()

imdb %>% mutate(nova_coluna = "texto") %>% View()

# Exercícios --------------------------------------------------------------

# 1. Crie uma coluna chamada prejuizo (orcamento - receita)
# e salve a nova tabela em um objeto chamado imdb_prejuizo.
# Em seguida, filtre apenas os filmes que deram prejuízo
# e ordene a tabela por ordem crescente de prejuízo.
# mutate, filter, arrange

imdb_prejuizo <- imdb %>%
  mutate(prejuizo = orcamento - receita)

imdb_prejuizo %>%
  filter(prejuizo > 0) %>%
  arrange(prejuizo) %>%
  View

# 2. Crie uma nova coluna que classifique o filme em
# "recente" (posterior a 2000) e "antigo" de 2000 para trás.
# mutate, ifelse

imdb %>%
  mutate(idade = ifelse(ano > 2000, "recente", "antigo")) %>%
  select(ano, idade) %>%
  arrange(ano) %>%
  View()

ifelse(
  imdb$ano > 2000,
  "recente",
  ifelse(imdb$ano < 2000, "antigo", "filme do ano 2000")
)

case_when(
  imdb$ano > 2000 ~ "recente",
  imdb$ano == 2000 ~ "filme do ano 2000",
  imdb$ano < 2000 ~ "antigo"
)

imdb %>%
  mutate(
    idade = ifelse(
      ano > 2000,
      "recente",
      ifelse(ano < 2000, "antigo", "filme do ano 2000")
    )
  ) %>%
  select(ano, idade) %>%
  arrange(ano) %>%
  View()

imdb %>%
  mutate(
    idade = case_when(
      ano > 2000 ~ "recente",
      ano == 2000 ~ "filme do ano 2000",
      ano < 2000 ~ "antigo"
    )
  ) %>%
  select(ano, idade) %>%
  arrange(ano) %>%
  unique()

imdb %>%
  mutate(
    flag_the = case_when(
      stringr::str_detect(titulo, "The") ~ "Existe a palavra the",
      stringr::str_detect(titulo, "the") ~ "Existe a palavra the",
      TRUE ~ "Não existe a palavra the"
    )
  ) %>%
  select(titulo, flag_the) %>%
  View()

# summarise ---------------------------------------------------------------

# Sumarizando uma coluna

imdb %>%
  summarise(media_orcamento = mean(orcamento, na.rm = TRUE))

# repare que a saída ainda é uma tibble


# Sumarizando várias colunas
imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm = TRUE),
  media_receita = mean(receita, na.rm = TRUE),
  media_lucro = mean(receita - orcamento, na.rm = TRUE)
)

# Diversas sumarizações da mesma coluna
imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm = TRUE),
  mediana_orcamento = median(orcamento, na.rm = TRUE),
  variancia_orcamento = var(orcamento, na.rm = TRUE)
)

# Tabela descritiva
imdb %>%
  # filter(ano > 2000) %>%
  summarise(
    media_orcamento = mean(orcamento, na.rm = TRUE),
    media_receita = mean(receita, na.rm = TRUE),
    qtd = n(),
    qtd_diretores = n_distinct(diretor)
  )


# funcoes que transformam -> N valores
log(1:10)
sqrt(1:10)
str_detect()

# funcoes que sumarizam -> 1 valor
mean(c(1, NA, 2))
mean(c(1, NA, 2), na.rm = TRUE)
n_distinct()


# group_by + summarise ----------------------------------------------------

# Agrupando a base por uma variável.

imdb %>% group_by(cor)

# Agrupando e sumarizando
imdb %>%
  group_by(cor) %>%
  summarise(
    media_orcamento = mean(orcamento, na.rm = TRUE),
    media_receita = mean(receita, na.rm = TRUE),
    qtd = n(),
    qtd_diretores = n_distinct(diretor)
  )

imdb %>%
  mutate(
    idade = ifelse(ano <= 2000, "antigo", "recente")
  ) %>%
  group_by(idade) %>%
  summarise(
    media_orcamento = mean(orcamento, na.rm = TRUE),
    media_receita = mean(receita, na.rm = TRUE),
    qtd = n(),
    qtd_diretores = n_distinct(diretor)
  )

# Exercícios --------------------------------------------------------------

# 1. Calcule a duração média e mediana dos filmes
# da base.
# summarise

imdb %>%
  summarise(duração_media = mean(duracao, na.rm = TRUE)) %>%
  View()

imdb %>%
  summarise(duração_mediana = median(duracao, na.rm = TRUE))

imdb %>%
  summarise(
    duração_media = mean(duracao, na.rm = TRUE),
    duração_mediana = median(duracao, na.rm = TRUE)
  )

# 2. Calcule o lucro médio dos filmes com duracao
# menor que 60 minutos.
# filter, summarise

imdb %>%
  filter(duracao < 60) %>%
  summarise(
    lucro_medio = mean(receita - orcamento, na.rm = TRUE)
  )

# Mais eficiente
imdb %>%
  filter(duracao < 60) %>%
  mutate(lucro = receita - orcamento) %>%
  summarise(lucro_medio = mean(lucro, na.rm = TRUE))

# Menos eficiente
imdb %>%
  mutate(lucro = receita - orcamento) %>%
  filter(duracao < 60) %>%
  summarise(lucro_medio = mean(lucro, na.rm = TRUE))

imdb %>%
  filter(duracao < 60)  %>%
  # select(duracao, receita, orcamento) %>%
  mutate(lucro = receita - orcamento ) %>%
  filter(lucro > 0) %>%
  summarise(lucro.medio = mean(lucro, na.rm = TRUE))

# 3. Apresente na mesma tabela o lucro médio
# dos filmes com duracao menor que 60 minutos
# e o lucro médio dos filmes com duracao maior
# ou igual a 60 minutos.
# mutate, group by, summarise

imdb %>%
  mutate(duracao60 =  ifelse(
    duracao < 60,
    "Menor que 60min",
    "Maior ou igual a 60min"
  ))  %>%
  mutate(lucro = receita - orcamento) %>%
  group_by(duracao60) %>%
  summarise(lucro.medio = mean(lucro, na.rm = TRUE))

imdb %>%
  mutate(
    duracao60 =  ifelse(
      duracao < 60,
      "Menor que 60min",
      "Maior ou igual a 60min"
    ),
    lucro = receita - orcamento
  )  %>%
  group_by(duracao60) %>%
  summarise(
    lucro.medio = mean(lucro, na.rm = TRUE),
    num_filmes = n()
  )

# left join ---------------------------------------------------------------

# A função left join serve para juntarmos duas
# tabelas a partir de uma chave.
# Vamos ver um exemplo bem simples.

band_members
band_instruments

left_join(band_members, band_instruments, by = "name")
left_join(band_instruments, band_members, by = "name")

left_join(band_members, band_instruments, by = "name") %>% filter(is.na(plays))

band_members %>% left_join(band_instruments)
band_instruments %>% left_join(band_members)

# Pacote stringr

stringr::str_to_lower()
stringr::str_to_upper()
stringr::str_trim()

# install.packages("abjutils")
abjutils::rm_accent("Águia")

# o argumento 'by'
band_members %>% left_join(band_instruments, by = "name")

# c("chave1", "chave2")

# De volta ao imdb...

# Vamos calcular a média do lucro e o lucro máximo dos filmes
# por diretor.
tab_lucro_diretor <- imdb %>%
  mutate(lucro = receita - orcamento) %>%
  group_by(diretor) %>%
  summarise(
    lucro_medio = mean(lucro, na.rm = TRUE),
    lucro_maximo = max(lucro, na.rm = TRUE),
  )

# E se quisermos colocar essa informação na base
# original? Para sabermos, por exemplo, o quanto
# o lucro de cada filme se afasta do lucro médio
# do diretor que o dirigiu.

# Usamos a funçõa left join para trazer a
# coluna lucro_medio para a base imdb, associando
# cada valor de lucro_medio ao respectivo diretor
left_join(imdb, tab_lucro_diretor, by = "diretor") %>%
  mutate(lucro = receita - orcamento) %>%
  select(titulo, diretor, lucro, lucro_medio) %>%
  View

# Salvando em um objeto
imdb_com_lucro_medio <- imdb %>%
  left_join(tab_lucro_diretor, by = "diretor")

# Calculando o lucro relativo. Vamos usar a
# função scales::percent() para formatar o
# nosso resultado.

scales::percent(c(0.05, 0.1))
scales::percent(0.5)
scales::percent(1)

scales::dollar(100, prefix = "R$")
scales::number(10000, big.mark = ".", decimal.mark = ",")
scales::number(0.1, big.mark = ".", decimal.mark = ",", accuracy = 0.1)

imdb_com_lucro_medio %>%
  mutate(
    lucro = receita - orcamento,
    lucro_relativo = (lucro - lucro_medio)/lucro_medio,
    lucro_relativo = scales::percent(lucro_relativo)
  ) %>%
  View()

# Fazendo de-para

depara_cores <- tibble(
  cor = c("Color", "Black and White"),
  cor_em_ptBR = c("colorido", "preto e branco")
)

left_join(imdb, depara_cores, by = c("cor")) %>% View()

imdb %>%
  left_join(depara_cores, by = c("cor")) %>%
  select(cor, cor_em_ptBR) %>%
  View()

# OBS: existe uma família de joins

band_instruments %>% left_join(band_members)
band_instruments %>% right_join(band_members)
band_instruments %>% inner_join(band_members)
band_instruments %>% full_join(band_members)


# Exercícios --------------------------------------------------------------

# 1. Salve em um novo objeto uma tabela com a
# nota média dos filmes de cada diretor. Essa tabela
# deve conter duas colunas (diretor e nota_imdb_media)
# e cada linha deve ser um diretor diferente.
# group_by, summarise

imdb_diretor <- imdb %>%
  group_by(diretor) %>%
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE))

# 2. Use o left_join para trazer a coluna
# nota_imdb_media da tabela do exercício 1
# para a tabela imdb original.
# left_join

left_join(imdb, imdb_diretor, by = "diretor") %>% View

imdb %>%
  left_join(imdb_diretor, by = "diretor") %>%
  select(titulo, diretor, nota_imdb, nota_media) %>%
  View()

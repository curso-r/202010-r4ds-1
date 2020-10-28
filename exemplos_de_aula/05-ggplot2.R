
# Carregar pacotes --------------------------------------------------------

library(tidyverse)

# Ler base IMDB -----------------------------------------------------------

imdb <- read_rds("dados/imdb.rds")

imdb <- imdb %>% mutate(lucro = receita - orcamento)

# Gráfico de pontos (dispersão) -------------------------------------------

# Apenas o canvas
imdb %>%
  ggplot()

ggplot(imdb)

# Salvando em um objeto
p <- imdb %>%
  ggplot()

# Gráfico de dispersão da receita contra o orçamento
imdb %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita))

# y = a + b * x
# y = 0 + 1 * b -> y = x
# Inserindo a reta x = y
imdb %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita)) +
  geom_abline(intercept = 0, slope = 1, color = "red")

# Observe como cada elemento é uma camada do gráfico.
# Agora colocamos a camada da linha antes da camada
# dos pontos.
imdb %>%
  ggplot() +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  geom_point(aes(x = orcamento, y = receita))

# reta vertical
imdb %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita)) +
  geom_vline(xintercept = 1e+8)

# reta horizontal
imdb %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita)) +
  geom_hline(yintercept = 4e+8, color = "orange")

# Atribuindo a variável lucro aos pontos
imdb %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucro))

# Categorizando o lucro antes
imdb %>%
  mutate(
    lucrou = ifelse(lucro <= 0, "Não", "Sim")
  ) %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucrou))

# Salvando um gráfico em um arquivo
p <- imdb %>%
  mutate(
    lucrou = ifelse(lucro <= 0, "Não", "Sim")
  ) %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucrou))

ggsave(
  filename = "meu_grafico.pdf",
  plot = p,
  # width = 10,
  # height = 20,
  units = "cm"
)


# Filosofia ---------------------------------------------------------------

# Um gráfico estatístico é uma representação visual dos dados
# por meio de atributos estéticos (posição, cor, forma,
# tamanho, ...) de formas geométricas (pontos, linhas,
# barras, ...). Leland Wilkinson, The Grammar of Graphics

# Layered grammar of graphics: cada elemento do
# gráfico pode ser representado por uma camada e
# um gráfico seria a sobreposição dessas camadas.
# Hadley Wickham, A layered grammar of graphics

# Exercícios --------------------------------------------------------------

# a. Crie um gráfico de dispersão da nota do imdb pelo orçamento.
#dicas: ggplot() aes() geom_point()

imdb %>%
  ggplot() +
  geom_point(aes(x = nota_imdb, y = orcamento))

imdb %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = nota_imdb))

# b. Pinte todos os pontos do gráfico de azul. (potencial pegadinha =P)

imdb %>%
  ggplot()+
  geom_point(aes(x = orcamento, y = nota_imdb), color = "blue")

imdb %>%
  mutate(cor = "yellow") %>% View()

imdb %>%
  ggplot()+
  geom_point(aes(x = orcamento, y = nota_imdb),
             color = "blue", size = 1)


# pegadinha
imdb %>%
  ggplot()+
  geom_point(aes(x = orcamento, y = nota_imdb, color = "blue"))

# Gráfico de linhas -------------------------------------------------------

# Nota média dos filmes ao longo dos anos

imdb %>%
  group_by(ano) %>%
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>%
  ggplot() +
  geom_line(aes(x = ano, y = nota_media))

# Número de filmes coloridos e preto e branco por ano

imdb %>%
  filter(!is.na(cor), !is.na(ano)) %>%
  group_by(ano, cor) %>%
  summarise(num_filmes = n()) %>%
  ggplot() +
  geom_line(aes(x = ano, y = num_filmes, color = cor))

# Nota média do Robert De Niro por ano
imdb %>%
  filter(ator_1 == "Robert De Niro") %>%
  group_by(ano) %>%
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>%
  ggplot() +
  geom_line(aes(x = ano, y = nota_media))

# Colocando pontos no gráfico
imdb %>%
  filter(ator_1 == "Robert De Niro") %>%
  group_by(ano) %>%
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>%
  ggplot() +
  geom_line(aes(x = ano, y = nota_media)) +
  geom_point(aes(x = ano, y = nota_media))

# Reescrevendo de uma forma mais agradável
imdb %>%
  filter(ator_1 == "Robert De Niro") %>%
  group_by(ano) %>%
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>%
  ggplot(aes(x = ano, y = nota_media)) +
  geom_line() +
  geom_point()

# Colocando as notas no gráfico
imdb %>%
  filter(ator_1 == "Robert De Niro") %>%
  group_by(ano) %>%
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>%
  mutate(
    nota_media = round(nota_media, 1),
    label = paste(ano, nota_media, sep = " - ")
  ) %>%
  ggplot(aes(x = ano, y = nota_media)) +
  geom_line() +
  geom_label(aes(label = label))

imdb %>%
  filter(ator_1 == "Robert De Niro") %>%
  group_by(ano) %>%
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>%
  mutate(
    nota_media = round(nota_media, 1),
    label = paste(ano, nota_media, sep = " - ")
  ) %>%
  ggplot(aes(x = ano, y = nota_media, label = label)) +
  geom_line(color = "blue", size = 2) +
  geom_label(fill = "yellow", color = "black", size = 10)


# Exercício ---------------------------------------------------------------

# Faça um gráfico do orçamento médio dos filmes ao longo dos anos.
# dicas: group_by() summarise() ggplot() aes() geom_line()

imdb %>%
  group_by(ano) %>%
  summarise(orcamento_medio = mean(orcamento, na.rm = TRUE)) %>%
  ggplot() +
  geom_line(aes(x = ano, y = orcamento_medio ))

# Gráfico de barras -------------------------------------------------------

# Número de filmes dos diretores da base
imdb %>%
  dplyr::count(diretor, name = "freq") %>%
  filter(!is.na(diretor)) %>%
  dplyr::top_n(10, freq) %>%
  ggplot() +
  geom_col(aes(x = diretor, y = freq))

imdb %>%
  top_n(10, orcamento)

# Tirando NA e pintando as barras
imdb %>%
  count(diretor) %>%
  filter(!is.na(diretor)) %>%
  top_n(10, n) %>%
  ggplot() +
  geom_col(
    aes(x = diretor, y = n, fill = diretor),
    color = "black",
    show.legend = FALSE
  )

# Invertendo as coordenadas
imdb %>%
  count(diretor) %>%
  filter(!is.na(diretor)) %>%
  top_n(10, n) %>%
  ggplot() +
  geom_col(
    aes(x = n, y = diretor),
    show.legend = FALSE
  )


# Ordenando as barras
imdb %>%
  count(diretor) %>%
  filter(!is.na(diretor)) %>%
  top_n(10, n) %>%
  mutate(
    diretor = forcats::fct_reorder(diretor, n, .desc = TRUE)
  ) %>%
  ggplot() +
  geom_col(
    aes(x = n, y = diretor),
    show.legend = FALSE
  )

# Colocando label nas barras
top_10_diretores <- imdb %>%
  count(diretor) %>%
  filter(!is.na(diretor)) %>%
  top_n(10, n)

top_10_diretores %>%
  mutate(
    # diretor = as.factor(diretor),
    diretor = fct_reorder(diretor, n)
  ) %>%
  ggplot() +
  geom_col(
    aes(x = n, y = diretor),
    show.legend = FALSE
  ) +
  geom_label(aes(x = n / 2, y = diretor, label = n))


# Exercícios --------------------------------------------------------------

# a. Transforme o gráfico do exercício anterior em um gráfico de barras.

imdb %>%
  group_by(ano) %>%
  summarise(orcamento_medio = mean(orcamento, na.rm = TRUE)) %>%
  ggplot() +
  geom_col(aes( x = ano, y = orcamento.medio))

# b. Refaça o gráfico apenas para filmes de 1989 para cá.

imdb %>%
  filter(ano >= 1989) %>%
  group_by(ano) %>%
  summarise(orcamento.medio = mean(orcamento, na.rm = TRUE)) %>%
  ggplot() +
  geom_col(aes( x = ano, y = orcamento.medio))



# [AVANÇADO] Gráfico de barras II: positions e labels ---------------------------------

diretor_por_filme_de_drama <- imdb %>%
  mutate(filme_de_drama = str_detect(generos, "Drama")) %>%
  count(diretor, filme_de_drama) %>%
  filter(
    !is.na(diretor),
    !is.na(filme_de_drama),
    diretor %in% top_10_diretores$diretor
  ) %>%
  mutate(
    diretor = forcats::fct_reorder(diretor, n)
  )

# Colocando cor nas barras com outra variável
# coisas novas: fill = filme_de_drama e position = position_stack(vjust = 0.5)
diretor_por_filme_de_drama %>%
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(aes(fill = filme_de_drama)) +
  geom_label(aes(label = n), position = position_stack(vjust = 0.5))

# position dodge (lado a lado)
diretor_por_filme_de_drama %>%
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(aes(fill = filme_de_drama), position = position_dodge(width = 1, preserve = "single")) +
  geom_text(aes(label = n), position = position_dodge(width = 1), hjust = -0.1)

# position fill (preenchido ate 100%)
diretor_por_filme_de_drama %>%
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(aes(fill = filme_de_drama), position = position_fill()) +
  geom_text(aes(label = n), position = position_fill(vjust = 0.5))

# Ordenar é um desafio =(
diretor_por_filme_de_drama %>%
  group_by(diretor) %>%
  mutate(proporcao_de_drama = sum(n[filme_de_drama])/sum(n)) %>%
  ungroup() %>%
  mutate(diretor = forcats::fct_reorder(diretor, proporcao_de_drama)) %>%
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(aes(fill = filme_de_drama), position = position_fill()) +
  geom_text(aes(label = n), position = position_fill(vjust = 0.5))

# Exercícios --------------------------------------------------------------

# a. Faça um gráfico de barras empilhados cruzando cor e classificacao
# dica: geom_col(position = "fill")

# b. adicione + scale_fill_brewer(palette = "Set3")  ao grafico

# Histogramas e boxplots --------------------------------------------------

# Histograma do lucro dos filmes do Steven Spielberg
imdb %>%
  filter(diretor == "Steven Spielberg") %>%
  ggplot() +
  geom_histogram(aes(x = lucro))

# Arrumando o tamanho das bases
imdb %>%
  filter(diretor == "Steven Spielberg") %>%
  ggplot() +
  geom_histogram(
    aes(x = lucro),
    binwidth = 100000000,
    color = "white",
    fill = "blue"
  )

# Boxplot do lucro dos filmes dos diretores
# fizeram mais de 15 filmes
imdb %>%
  filter(!is.na(diretor)) %>%
  group_by(diretor) %>%
  filter(n() >= 15) %>%
  ggplot() +
  geom_boxplot(aes(x = diretor, y = lucro)) +
  geom_point(aes(x = diretor, y = lucro), alpha = 0.5)

imdb %>%
  filter(!is.na(diretor)) %>%
  group_by(diretor) %>%
  filter(n() >= 15) %>%
  ggplot() +
  geom_boxplot(aes(x = diretor, y = lucro)) +
  geom_jitter(aes(x = diretor, y = lucro), color = "royal blue")

# Ordenando pela mediana

imdb %>%
  filter(!is.na(diretor)) %>%
  group_by(diretor) %>%
  filter(n() >= 15) %>%
  ungroup() %>%
  mutate(diretor = forcats::fct_reorder(diretor, lucro, .fun = mean, na.rm = TRUE)) %>%
  ggplot() +
  geom_boxplot(aes(x = diretor, y = lucro))


# Exercícios --------------------------------------------------------------

#a. Descubra quais são os 5 atores que mais aparecem na coluna ator_1.
# dica: count() top_n().

atores_mais_frequentes <- imdb %>%
  count(ator_1, name = "frequencia") %>%
  top_n(5, frequencia) %>%
  pull(ator_1)


#b. Faça um boxplot do lucro dos filmes desses atores.

imdb %>%
  filter(ator_1 == "Denzel Washington" | ator_1 == "J.K. Simmons" | ator_1 == "Johnny Depp")
  filter(ator_1 %in% atores_mais_frequentes) %>%
  ggplot() +
  geom_boxplot(aes(x = ator_1, y = lucro))

# Título e labels ---------------------------------------------------------

# Labels
imdb %>%
  ggplot() +
  geom_point(mapping = aes(x = orcamento, y = receita, color = lucro)) +
  labs(
    x = "Orçamento ($)",
    y = "Receita ($)",
    color = "Lucro ($)",
    title = "Gráfico de dispersão",
    subtitle = "Receita vs Orçamento",
    caption = "Consegue colocar uma legenda"
  )

# Escalas
imdb %>%
  group_by(ano) %>%
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>%
  ggplot() +
  geom_line(aes(x = ano, y = nota_media)) +
  scale_x_continuous(breaks = seq(1916, 2016, 10)) +
  scale_y_continuous(breaks = seq(0, 10, 2))

# Visão do gráfico
imdb %>%
  group_by(ano) %>%
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>%
  ggplot() +
  geom_line(aes(x = ano, y = nota_media)) +
  scale_x_continuous(breaks = seq(1916, 2016, 10)) +
  scale_y_continuous(breaks = seq(0, 10, 2)) +
  coord_cartesian(ylim = c(0, 10))

imdb %>%
  group_by(ano) %>%
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>%
  ggplot() +
  geom_line(aes(x = ano, y = nota_media)) +
  scale_x_continuous(breaks = seq(1916, 2016, 10)) +
  scale_y_continuous(breaks = seq(0, 10, 2)) +
  coord_cartesian(xlim = c(1989, 2016))

# Cores -------------------------------------------------------------------

# Escolhendo cores pelo nome

imdb %>%
  count(diretor) %>%
  filter(!is.na(diretor)) %>%
  top_n(5, n) %>%
  ggplot() +
  geom_bar(
    aes(x = n, y = diretor),
    fill = "orange",
    stat = "identity"
  )

imdb %>%
  count(diretor) %>%
  filter(!is.na(diretor)) %>%
  top_n(5, n) %>%
  ggplot() +
  geom_bar(
    aes(x = n, y = diretor, fill = diretor),
    stat = "identity"
  ) +
  scale_fill_manual(values = c("#b139cc", "royalblue", "purple", "salmon", "darkred"))
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# Escolhendo pelo hexadecimal
imdb %>%
  count(diretor) %>%
  filter(!is.na(diretor)) %>%
  top_n(5, n) %>%
  ggplot() +
  geom_bar(
    aes(x = n, y = diretor, fill = diretor),
    stat = "identity",
    show.legend = FALSE
  ) +
  scale_fill_manual(
    values = c("#ff4500", "#268b07", "#ff7400", "#abefaf", "#33baba")
  )



# Mudando textos da legenda
imdb %>%
  filter(!is.na(cor)) %>%
  group_by(ano, cor) %>%
  summarise(num_filmes = n()) %>%
  ggplot() +
  geom_line(aes(x = ano, y = num_filmes, color = cor)) +
  scale_color_discrete(labels = c("Preto e branco", "Colorido"))

# Definiando cores das formas geométricas
imdb %>%
  ggplot() +
  geom_point(mapping = aes(x = orcamento, y = receita), color = "#ff7400")

# Tema --------------------------------------------------------------------

# Temas prontos
imdb %>%
  ggplot() +
  geom_point(mapping = aes(x = orcamento, y = receita)) +
  # theme_bw()
  # theme_classic()
  # theme_dark()
  theme_minimal()

# A função theme()
imdb %>%
  ggplot() +
  geom_point(mapping = aes(x = orcamento, y = receita)) +
  labs(
    title = "Gráfico de dispersão",
    subtitle = "Receita vs Orçamento"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, colour = "red", size = 20),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid.major.x = element_line(color = "purple"),
    panel.grid.minor.x = element_blank(),
    panel.background = element_rect(fill = "orange", color = "black")
  )

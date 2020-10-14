
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Configuração inicial

#### Passo 1: Instalar pacotes

``` r
install.packages("remotes")

# instalar pacote da Curso-R
remotes::install_github("curso-r/CursoR")
```

#### Passo 2: Criar um projeto do RStudio

Faça um projeto do RStudio para usar durante todo o curso e em seguida
abra-o.

``` r
install.packages("usethis")
usethis::create_project("caminho_ate_o_projeto/nome_do_projeto")
```

#### Passo 3: Baixar o material

Certifique que você está dentro do projeto criado no passo 2 e rode o
código abaixo.

**Observação**: Assim que rodar o código abaixo, o programa vai pedir
uma escolha de opções. Escolha o número correspondente ao curso de R
para Ciência de Dados 1\!

``` r
# Baixar ou atualizar material do curso
CursoR::atualizar_material()
```

## Slides

| Slide                              | Link                                                                       | Link em PDF                                                                                 |
| :--------------------------------- | :------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------ |
| slides/01-introducao-ao-curso.html | <https://curso-r.github.io/main-r4ds-1/slides/01-introducao-ao-curso.html> | <a href='https://curso-r.github.io/main-r4ds-1/slides/01-introducao-ao-curso.pdf'> PDF </a> |
| slides/02-introducao-ao-r.html     | <https://curso-r.github.io/main-r4ds-1/slides/02-introducao-ao-r.html>     | <a href='https://curso-r.github.io/main-r4ds-1/slides/02-introducao-ao-r.pdf'> PDF </a>     |
| slides/03-importacao.html          | <https://curso-r.github.io/main-r4ds-1/slides/03-importacao.html>          | <a href='https://curso-r.github.io/main-r4ds-1/slides/03-importacao.pdf'> PDF </a>          |
| slides/04-manipulacao.html         | <https://curso-r.github.io/main-r4ds-1/slides/04-manipulacao.html>         | <a href='https://curso-r.github.io/main-r4ds-1/slides/04-manipulacao.pdf'> PDF </a>         |
| slides/05-ggplot2.html             | <https://curso-r.github.io/main-r4ds-1/slides/05-ggplot2.html>             | <a href='https://curso-r.github.io/main-r4ds-1/slides/05-ggplot2.pdf'> PDF </a>             |

## Scripts usados em aula

| script                                    | link                                                                                                 |
| :---------------------------------------- | :--------------------------------------------------------------------------------------------------- |
| 00-instalacao-alternativa-pacote-cursor.R | <https://curso-r.github.io/202010-r4ds-1/exemplos_de_aula/00-instalacao-alternativa-pacote-cursor.R> |
| 00-primeiros-passos.R                     | <https://curso-r.github.io/202010-r4ds-1/exemplos_de_aula/00-primeiros-passos.R>                     |
| 01-introducao-ao-R.R                      | <https://curso-r.github.io/202010-r4ds-1/exemplos_de_aula/01-introducao-ao-R.R>                      |
| 02-controle-de-fluxo.R                    | <https://curso-r.github.io/202010-r4ds-1/exemplos_de_aula/02-controle-de-fluxo.R>                    |
| 03-importacao.R                           | <https://curso-r.github.io/202010-r4ds-1/exemplos_de_aula/03-importacao.R>                           |

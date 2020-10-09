# Controle de fluxo -------------------------------------------------------

# É muito comum usarmos operadores lógicos para fazer os nossos códigos tomarem decisões.
# Para isso, utilizamos os controladores de fluxo.

# if: faz uma ação se a condição for atendida

x <- 1
if(x == 1) {
  Sys.time()
}

# if/else: faz uma ação se a primeira condição for atendida,
# uma segunda ação se a segunda condição for atendida, e assim por diante.

x <- 0

if(x < 0){
  "negativo"
} else {
  "não negativo"
}

# else-if: generaliza o comportamento do if
x <- 5
if(x < 0) {
  "negativo"
} else if(x == 0) {
  "neutro"
} else {
  "positivo"
}

# for: realiza uma operação repetidamente dentro de um escopo

for(i in 1:10){
  texto <- paste0("Esse aqui é o número ", i)
  print(texto)
}

paste0("Esse aqui é o número ", c(1:10))

# podemos juntar for's e if's! isso é muito comum, inclusive
x <- 2
x %% 2 == 0

9 %% 2

for(i in 1:10) {
  if(i %% 2 != 0) {
    texto <- paste0("Essa é a repetição ", i, "!")
    print(texto)
  }
}


# Novos exercícios ----------------------------

# 1. Crie um laço com for que retorne se é verdadeiro que
# um elemento do vetor x é um número par.
# Ex: se o número for par, deve retornar TRUE,
# se for impar, deve retornar false.
x <- c(10, 3, 5, 1, 3, 4, 8, 9, 10)
# Dicas:
# length(x) - retorna o comprimento do vetor
# %% é usado para obter o resto da divisão.
# Ex: 2 %% 2 retornará 0.
# 10 %% 2 retornará 0.
# 10 %% 3 retornará 1.
# Portanto números pares são todos
# os que a seguinte sentença é verdadeira: numero %% 2 == 0

for (i in 1:length(x)) {
  print(x[i] %% 2 == 0)
}

# 2. Adapte a resposta do exercício anterior,
# e usando o if/else, faça com que seja retornado uma mensagem
# se o número é par ou impar.
# Ex: No caso de x[1], deve retornar:  "O número 10 é par"

for (i in 1:length(x)) {
  if(x[i] %% 2 == 0) {
    print(paste("O número", x[i], "é par"))
  } else {
    print(paste("O número", x[i], "é ímpar"))
  }
}



# Desafios --------------------------------------------------------------

x <- c(10, 3, 5, 1, 3, 4, 8, 9, 10)

# 1. Crie um laço com for que imprima as médias acumuladas do vetor x.
# Isso é, primeiro vamos imprimir 10, depois (10+3)/2, depois (10+3+5)/3, etc.

# 2. Adapte o laço que você fez no exercício 1 para imprimir a média acumulada
# só quando essas médias forem maior do que 5.



# Instalação Curso-R quando não funciona a instalação via github
# Caso não tenha instalado o pacote remotes, precisa instalar
install.packages("remotes")


# Fazer o download do pacote, em formato ZIP
# A url é o link de onde o pacote está
# destfile é onde e com qual nome queremos salvar. Nesse caso estamos salvando o arquivo no nosso projeto, com o nome "master.zip"
download.file(url = "https://github.com/curso-r/CursoR/archive/master.zip", destfile = "master.zip")
# Verifique se o arquivo foi baixado!
list.files(pattern = ".zip") # um dos elementos no resultado que aparece no console deve ser "master.zip"


## Caso não tenha sido baixado, voce pode baixar manualmente o arquivo, através do link:
## https://github.com/curso-r/CursoR/archive/master.zip
## Depois, copie este arquivo para a pasta principal do seu projeto


# Usando uma função do pacote remotes, instalamos o pacote usando este arquivo zip:

remotes::install_local("master.zip")

# O R vai perguntar, no console, se você quer atualizar os pacotes depedência para uma versão mais atual.
# Você pode digitar 3 e apertar ENTER (isso significa que nenhum pacote será atualizado).


# Vamos testar se funcionou?

CursoR::atualizar_material()

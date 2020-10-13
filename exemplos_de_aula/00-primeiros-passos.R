# Primeiro é necessário ter o RStudio instalado!

# Crie um projeto (como uma pasta) que será usado ao longo do curso:

# File > New Project > New Directory > New Project >
# Preencha o 'Directory Name': nome do projeto/pasta
# Clique em Browse e escolha em qual pasta quer criar o projeto
# Clique em 'Create project' e o projeto será criado

# A partir de agora trabalharemos no projeto que você criou
# (pode conferir olhando
# no canto superior direito se aparece o nome do projeto
# ao lado de um cubo azul com R):

# Instale os pacotes necessários:
install.packages("remotes")

# instalar pacote da Curso-R
remotes::install_github("curso-r/CursoR")


# Baixar ou atualizar material do curso
CursoR::atualizar_material() # Nessa etapa, será perguntado
# qual é o material que deseja atualizar.
# Para escolher o material deste curso, digite no console: 1
# e clique enter


# ... os arquivos serão baixados, espere um pouco


# Depois de todos os arquivos serem baixados,
# você terá no seu projeto 3 pastas:
# - Slides
# - Dados
# - exemplos_de_aula


# Preparação concluída :)

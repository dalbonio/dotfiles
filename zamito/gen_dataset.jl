using Pkg
Pkg.activate(".")

using CSV

#matriz aleatoria com numeros de 1 a 10, com 16 linhas, 4 colunas
R = rand(1:10, 16, 4)

#transforma a ultima coluna no valor 0 caso a soma seja menor que 20, e 1 caso seja maior
R[:, 4] = sum.(eachrow(R[:, 1:3])) .> 20

CSV.write("dataset.csv", R)

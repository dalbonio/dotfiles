using Pkg
Pkg.activate(".")

using CSV, DataFrames

rows = 119746

if length(ARGS) > 0
	rows = parse(Int64, ARGS[1])
end

print("generating a ", rows, " rows dataset...\n")

#matriz aleatoria com numeros de 1 a 10, com 16 linhas, 4 colunas
R = rand(1:10, rows, 4)

#transforma a ultima coluna no valor 0 caso a soma seja menor que 20, e 1 caso seja maior
R[:, 4] = sum.(eachrow(R[:, 1:3])) .> 20

CSV.write("dataset.csv", DataFrame(R), writeheader=false, delim=" ")

print("dataset generated!\n")
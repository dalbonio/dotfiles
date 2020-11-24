using Pkg
Pkg.activate(".")

using CSV, Plots, DataFrames, Statistics, StatsPlots
df = CSV.read("tempos.csv")
df = df[51:end, :]
x = combine(groupby(df, "Dataset Size"), nrow)["Dataset Size"]
ptime = reshape(df["Parallel Time"], (10,5))
yparallel = mean.(eachcol(ptime))

stime = reshape(df["Sequential Time"], (10,5))
yseq = mean.(eachcol(stime))
plotdf = DataFrame(a = x, b = yparallel, c = yseq)
@df plotdf plot(:a, [:b, :c], labels=["Tempo Sequencial" "Tempo Paralelo"])
plot!(title = "Paralelo x Sequencial", xlabel = "Tamanho do Dataset", ylabel = "Tempo em segundos", xlims=[x[1], x[end]])
png("parxseq")


speedup = reshape(df["Speedup"], (10,5))
yspeedup = mean.(eachcol(speedup))

speedupplot = DataFrame(a = x, b = yspeedup)
@df speedupplot plot(:a, [:b, ones(5)], labels=["Speedup"])
plot!(title = "Speedup por Tamanho", xlabel = "Tamanho do Dataset", ylabel = "Speedup", xlims=[x[1], x[end]])
png("speedup")

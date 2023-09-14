using TypedTables
using CSV
using DataFrames
using Plots

Weight = Table(CSV.File("Weight.csv"))
scatter(Weight.Height, Weight.Weight)

α = 0
β = 0
λ = 0.09
γ = 0.00000008
X = Weight.Height
Y = Weight.Weight

h(x) = α*x .+ β
α -= λ * sum((h(X) - Y)) / 6
β -= γ * sum((h(X) - Y).*X) / 6
plot!(h)

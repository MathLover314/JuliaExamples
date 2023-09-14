using CSV
using TypedTables
using DataFrames
using Plots

house_data = Table(CSV.File("housingdata.csv"))
scatter(
    house_data.size,
    house_data.price
)

X = house_data.size
Y = house_data.price

function E(Z)
    sum(Z)/length(Z)
end

ran = 500
function E(Z, W, w)
    r = []
    for i in 1:length(Z)
        if abs(W[i] - w) < ran
            push!(r, Z[i])
        end
    end
    E(r)
end

function D(Z)
    ez = E(Z)
    sum(abs.(Z.-ez))/length(Z)
end

function LSR(x, y)
    EX = E(x)
    EY = E(y)
    DX = D(x)
    DY = D(y)
    return DY/DX, EY - EX*DY/DX
end

a, b = LSR(X, Y)
f(x) = a*x+ b
plot!(f)

function FLR(x, y)
    r = []
    for e in y
        push!(r, E(x, y, e))
    end
    r
end

a = FLR(Y, X)
scatter!(X, a)

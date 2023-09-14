using CSV
using TypedTables
using Plots

data = CSV.File("housingdata.csv")
X = data.size
Y = data.price

scatter(X, Y)

function distribute(population, cond)
    right, left = [], []
    for prop in population
        if prop > cond
            push!(left, prop)
        else
            push!(right, prop)
        end
    end
    mean(right), mean(left)
end

function mean(population)
    sum(population)/length(population)
end


x, y = mean(X), mean(Y)
x1, x2 = distribute(X, x)
y1, y2 = distribute(Y, y)

a = (y2 - y)/(x2 - x)
b = y2 - a*x2
f(x) = a*x+b
plot!(f)
scatter!((x2,y2))
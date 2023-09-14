using CSV
using TypedTables
using DataFrames
using Plots

data_drug = Table(CSV.File("drug200.csv"))

function ch(H)
    r = []
    for e in H
        if e == "HIGH"
            push!(r, "Blue")
        else
            push!(r, "Red")
        end
    end
    r
end

scatter(
    data_drug.Age,
    data_drug.Na_to_K,
    color = ch(data_drug.Cholesterol)
)

function addNode(z, axis)
    maxIG = Inf
    r = 0
    dim = 0
    entropy_whole = entropy(z)
    for t in 1:axis
        for e in z
            IG = entropy_whole - entropy(divide(z, e[t], t))
            if IG < maxIG
                maxIG = IG
                r = e[t]
                dim = t
            end
        end
    end
    r, dim
end

function divide(z, cond, t)
    r1 = []
    r2 = []
    for e in z
        if e[t] < cond
            push!(r1, e)
        else
            push!(r2, e)
        end
    end
    r1, r2
end

function lenall(z)
    r = 0
    for e in z
        r += length(e)
    end
    r
end


function entropy(z)
    p = length.(z) ./ lenall(z)
    -sum(p.*log2.(p))
end

tree = []

r1, d1 = addNode(data_drug, 2)
r2, d2 = addNode(divide(data_drug, r1, d1)[1], 2)
r3, d3 = addNode(divide(data_drug, r1, d1)[2], 2)

plot!([1, 70], [r1, r1])
plot!([r2, r2], [1, 35])
plot!([r3, r3], [1, 35])
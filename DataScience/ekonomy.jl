using CSV
using TypedTables

income = [40_000, 55_000, 70_000, 100_000, 115_000, 130_000, 135_000]

function expec(l)
    sum(l) / length(l)
end

function dystr(l)
    c = expec(l)
    T = 0
    for x in l
        T += (x - c)^2
    end
    T
end

function dyst(a, c1, c2)
    if abs(a - c1) > abs(a - c2)
        true
    else
        false
    end
end

function divide(l, c1, c2)
    k1 = []
    k2 = []
    for x in l
        if dyst(x, c1, c2)
            push!(k1, x)
        else
            push!(k2, x)
        end
    end
    k1, k2
end

k1 = []
k2 = []

c1 = rand(income)
c2 = rand(income)

empty!(k1)
empty!(k2)

for i in 1:4
    k1, k2 = divide(income, c1, c2)
    c1 = expec(k1)
    c2 = expec(k2)
    print(k1)
    print(k2)
    print("\n")
end
print(c1)
print(c2)
using CSV
using TypedTables
using DataFrames
using Plots

Shirt = Table(CSV.File("Tshirt.csv"))

hight = [Shirt[i][1] for i in 1:10]
weight = [Shirt[i][2] for i in 1:10]
hair = [Shirt[i][3] for i in 1:10]
gender = [Shirt[i][4] for i in 1:10]

i1, i2 = rand(1:10), rand(1:10)
c1 = (hight[i1],weight[i1])
c2 = (hight[i2],weight[i2])

k1 = []
k2 = []

function expec(l)
    if length(l) > 0
        sum(l) / length(l)
    else
        0
    end
end

function dyst(a, c1, c2)
    if abs(a - c1) > abs(a - c2)
        true
    else
        false
    end
end

function ch(g)
    list = []
    for a in g
        if a == "M"
            push!(list, "Blue")
        else
            push!(list, "Pink")
        end
    end
    list
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
    if length(k1) > length(k2)
        k1, k2
    else
        k2, k1
    end
end

scatter(
    hight,
    weight,
    color = ch(gender),
    marksize = 10
)


for i in 1:4
    x1, x2 = divide(hight, c1[1], c2[1])
    y1, y2 = divide(weight, c1[2], c2[2])
    k1 = [(x1[i], y1[i]) for i in 1:min(length(x1), length(y1))]
    k2 = [(x2[i], y2[i]) for i in 1:min(length(x2), length(y2))]
    if length(k1) > 0 && length(k2) > 0
        c1 = (expec(k1[1]), expec(k1[2]))
        c2 = (expec(k2[1]), expec(k2[2]))
    end
end

print(c1)
print(c2)
round(Int, 2.4)
push!(hight, round(Int, c1[1]),round(Int, c2[1]))
push!(weight, round(Int, c1[2]), round(Int, c2[2]))

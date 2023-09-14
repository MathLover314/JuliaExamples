using TypedTables
using CSV
using DataFrames
using Plots

MathInf = Table(CSV.File("MathInf.csv"))

function dAng(N1, N2)
    mod_N1 = sqrt(N1[1]^2 + N1[2]^2)
    mod_N2 = sqrt(N2[1]^2 + N2[2]^2)
    skalar = N1[1] * N2[1] + N1[2] * N2[2]
    skalar / (mod_N1 * mod_N2)
end

function ch(g)
    list = []
    for a in g
        if a == "inf"
            push!(list, "Blue")
        else
            push!(list, "Green")
        end
    end
    list
end

alg = [MathInf[i][1] for i in 1:15]
com = [MathInf[i][2] for i in 1:13]
thm = [MathInf[i][3] for i in 1:13]

scatter(
    alg,
    com,
    color = ch(thm),
    markersize=10,
)


function themeImp(N)
    closest = Inf
    finalT = "None"
    for i in 1:13
        distance = dAng((alg[i], com[i]), N)
        if distance < closest
            closest = distance
            finalT = thm[i]
        end
    end
    finalT
end

k = 5
algN = []
comN = []
thmN = []

empty!(algN)
empty!(comN)
empty!(thmN)

for x in 0:k:150
    for y in 0:k:150
        push!(algN, x)
        push!(comN, y)
        push!(thmN, themeImp((x, y)))
    end
end

scatter(
    algN,
    comN,
    color = ch(thmN),
    markersize=10,
)

x = range(0, 10, 100)
y = sin.(x)
z = exp.(-x.^2)
plot(x, y, z, label="gradient")
plotly()
plot(size=(600,600))
my_cg = cgrad([:blue,:red,:orange,:yellow]);
f(x,y) = x^2+y^2
xs = range(-5, stop=5, length=40)
ys = range(-5, stop=5, length=40)
plot(xs, ys, f, st = [:surface, :contourf],palette=cgrad(:blues).colors)
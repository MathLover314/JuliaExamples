using TypedTables
using CSV
using DataFrames
using Plots

temp = [10, 25, 15, 20, 18, 20, 22, 24]
vel = [0, 0, 5, 3, 7, 10, 5, 6]
grd = ["Cold", "Hot", "Cold", "Hot", "Cold", "Cold", "Hot", "Hot"]

HotCold = Table(
    Temperature = temp,
    Velocity = vel,
    Grade = grd 
)

function dMan(N1, N2)
    abs(N1[1] - N2[1]) + abs(N1[2] - N2[2])
end

function dEuc(N1, N2)
    sqrt((N1[1]-N2[1])^2 + (N1[2]-N2[2])^2)
end

function ch(g)
    list = []
    for a in g
        if a == "Cold"
            push!(list, "Blue")
        else
            push!(list, "Red")
        end
    end
    list
end

CSV.write("HotCold.csv", HotCold)

scatter(
    HotCold.Temperature,
    HotCold.Velocity,
    color = ch(HotCold.Grade),
    markersize=10,
    xticks = 0:5:35,
    yticks = 0:2:10
)

function grdImp(N)
    closest = Inf
    finalT = "None"
    for i in 1:8
        distance = dEuc((temp[i], vel[i]), N)
        if distance < closest
            closest = distance
            finalT = grd[i]
        end
    end
    finalT
end

k = 1
tempN = []
velN = []
grdN = []

empty!(tempN)
empty!(velN)
empty!(grdN)

for x in 0:k:30
    for y in 0:k:10
        push!(tempN, x)
        push!(velN, y)
        push!(grdN, grdImp((x, y)))
    end
end

scatter(
    tempN,
    velN,
    color = ch(grdN),
    markersize=10,
    xticks = 0:5:35,
    yticks = 0:2:10
)

function facmod(n, m)
    res = 1
    for i in 2:n
        res = (res * i) % m
        if res == 0 
            res
        end
    end
    res
end

1+1
facmod(100000000, 20120341231)
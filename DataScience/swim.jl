using CSV
using TypedTables

Swimmer = Table(CSV.File("Swimmer.csv"))
costume = [Swimmer[i][1] for i in 1:6]
water = [Swimmer[i][2] for i in 1:6]
swim = [Swimmer[i][3] for i in 1:6]

function entropy(rv)
    E = 0
    for p in rv
        if p != 0
            E += -p * log2(p)
        end
    end
    E
end

function infGain(S, A, O)
    T = 0
    for i in 1:length(A)
        p = Pcond(O, "Yes", S, A[i])
        T -= entropy([p, 1-p]) * length(O[S .== A[i]]) / 6
    end
    T += E_S
    T
end

function Pcond(arr1, c1, arr2, c2)
    l=[]
    for i in 1:6
        if arr1[i] == c1
            push!(l, i)
        end
    end
    count(i -> (arr2[i] == c2 && i in l), 1:6) / count(i -> (arr2[i] == c2), 1:6)
end

P_S = count(i -> (swim[i] == "Yes"), 1:6) / 6
E_S = entropy([P_S, 1-P_S])

E_Sc = infGain(costume, ["No", "Bikini", "Costume"], swim)
E_Sw = infGain(water, ["cold", "warm"], swim)


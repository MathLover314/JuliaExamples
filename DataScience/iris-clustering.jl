using CSV
using TypedTables
using DataFrames
using Plots

iris_data = Table(CSV.File("Iris.csv"))
scatter(iris_data.SepalLengthCm, iris_data.SepalWidthCm)


function mean(arr)
    sum(arr)/length(arr)
end

function minn(arr)
    r = Inf
    for e in arr
        if e < r
            r = e
        end
    end
    r
end

function maxx(arr)
    r = 0
    for e in arr
        if e > r
            r = e
        end
    end
    r
end


function metric(a, b)
    sqrt(sum((b .- a).^2))
end

function norm(v)
    v / sum(v)
end

function divide(arr, c)
    clusters = [[] for i in 1:3]
    distr_vector = []
    for i in 1:150
        d = [0.0, 0.0, 0.0]
        ps = []
        for k in 1:3
            d[k] = metric(collect(arr[i]), c[k])
        end
        d = norm(d)
        push!(distr_vector, d)
        min_d = Inf
        min_k = 0
        for k in 1:3
            if d[k] < min_d
                min_d = d[k]
                min_k = k
            end
        end
        push!(clusters[min_k], collect(arr[i]))
    end
    clusters, distr_vector 
end

function ch(arr)
    r = []
    for i in 1:150
        push!(r, RGB(arr[i][1], arr[i][2],arr[i][3]))
    end
    r
end

p_min = [minn(ch) for ch in columns(iris_data)]
p_max = [maxx(ch) for ch in columns(iris_data)]
c_start = [p_min * 2/3 + p_max*1/3, p_min*1/2+p_max*1/2,p_min * 1/3 + p_max*2/3]
clusters, DV = divide(iris_data, c_start)
DV
for k in 1:30
    c = [mean(clusters[1][i]) for i in 1:3]
    clusters = divide(iris_data, c)
end
c = [mean(clusters[i]) for i in 1:3]
scatter(
    iris_data.SepalLengthCm,
    iris_data.SepalWidthCm,
    color = ch(DV)
)

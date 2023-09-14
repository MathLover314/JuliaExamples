using CSV
using TypedTables
using DataFrames
using Plots

data_wine = Table(CSV.File("wine-clustering.csv"))

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

function divide(arr, c)
    clusters = [[] for i in 1:3]
    for i in 1:178
        d = Inf
        closest_p = 1
        for k in 1:3
            if metric(collect(arr[i]), c[k]) < d
                d = metric(collect(arr[i]), c[k])
                closest_p = k
            end
        end
        push!(clusters[closest_p], collect(arr[i]))
    end
    clusters
end

p_min = [minn(ch) for ch in columns(data_wine)]
p_max = [maxx(ch) for ch in columns(data_wine)]
c_start = [p_min * 2/3 + p_max*1/3, p_min*1/2+p_max*1/2,p_min * 1/3 + p_max*2/3]
clusters = divide(data_wine, c_start)

for k in 1:30
    c = [mean(clusters[i]) for i in 1:3]
    clusters = divide(data_wine, c)
end

clusters[3]
scatter(title = "Wine Clustering", label=["first type", "second type", "third type"])
xlabel!("alcohol")
ylabel!("malic acid")
scatter!([(clusters[2][i][1], clusters[2][i][2]) for i in 1:27], label = "first")
c = [mean(clusters[i]) for i in 1:3]
scatter!((c[1][1], c[1][2]))

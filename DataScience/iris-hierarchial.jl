using CSV
using TypedTables
using DataFrames
using Plots

iris_data = Table(CSV.File("Iris.csv"))
scatter(iris_data.SepalLengthCm, iris_data.SepalWidthCm)
max_range = 0.25
data = [(iris_data[i][2], iris_data[i][3]) for i in 1:150]
clusters = [[(iris_data[i][2], iris_data[i][3])] for i in 1:150]

function metric(a, b)
    sqrt(sum((b .- a).^2))
end

function substitute(arr1)
    arr = arr1
    d = length(arr)
    result = []
    for i in 1:d
        for j in 1:d
            if i != j
                A◠B = intersectt(arr[i], arr[j])
                if length(A◠B) > 0
                    A◡B = add(arr[i], arr[j])
                    push!(result, A◡B)
                    break
                end
            end
        end
    end
    unique(result)
end

function intersectt(a, b)
    result = []
    for e in a
        if e in b
            push!(result, e)
        end
    end
    result
end

function add(a, b)
    result = a
    for e in b
        if !(e in a)
            push!(result, e)
        end
    end
    result
end

function cut(a, b)
    result = []
    for e in a
        if !(e in b)
            push!(result, e)
        end
    end
    result
end

for j in 1:150
    d = Inf
    for i in 1:150
        d0 = metric((iris_data[j][2], iris_data[j][3]), (iris_data[i][2], iris_data[i][3]))
        if d0 < max_range && d > 0
            push!(clusters[j], (iris_data[i][2], iris_data[i][3]))
        end
    end
end


substitute([[2, 4], [5, 3], [4, 1], [1, 6], [1, 7]])
a = substitute(a)
scatter!(
    [a[1][i][1] for i in 1:length(a[1])],
    [a[1][i][2] for i in 1:length(a[1])]
)

clusters
using Plots

HEIGHT = 20
WIDTH = 20
A = rand(HEIGHT, WIDTH)

heatmap(A)
max_diff = 0.01
metric(x, y) = abs(x[1] - y[1]) + abs(x[2] - y[2])

function ball(center, radius)
    L = []
    for x in 1:WIDTH
        for y in 1:HEIGHT
            if  metric(center, (x,y)) <= radius
                push!(L, (x, y))
            end
        end
    end
    L
end

volume = []
for r in 1:10
    copies = 1
    for x in 1:WIDTH
        for y in 1:HEIGHT
            for p in ball((x, y), r)
                if abs(A[p[1], p[2]] - A[x, y]) < max_diff
                    copies += 1
                end
            end
        end
    end
    push!(volume, copies)
end
volume
plot(volume)
using CSV
using TypedTables
using DataFrames
using Plots

weight(h, p) = p[2] * h + p[1]

Weight = Table(CSV.File("Weight.csv"))
weit = [Weight[i][1] for i in 1:5]
height = [Weight[i][2] for i in 1:5]

function expec(p)
    e = (0.0, 0.0)
    for i in 1:5
        term = height[i] - p[1] - p[2] * weit[i]
        e = (e[1] + term, e[2] + term * weit[i])
    end
    e
end

point = (1.0, 1.0)
old_point = (1.0, 1.0)
learning_rate = 0.01
acceptable_error = 0.1

for i in 1:100
    gradient = expec(old_point)
    point = (point[1] + old_point[1] + learning_rate * gradient[1], point[2] + old_point[2] + learning_rate * gradient[2])
    if abs(point[1] - old_point[1]) <= acceptable_error && abs(point[2] - old_point[2]) <= acceptable_error
        break
    end
    old_point = point
end

scatter(
    weit,
    height
)

f(x) = point[1] * x +point[2]
point
plot!(f)

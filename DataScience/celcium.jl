using CSV
using TypedTables
using DataFrames
using Plots

function angle(c, f)
    a1 = 0
    a2 = 0
    x = expec(f)
    for i in 1:6
        a1 += (f[i] - x) * c[i]
        a2 += (f[i] - x)^2
    end
    a1/a2
end

function norm(c, f)
    x = expec(f)
    y = expec(c)
    y - angle(c, f) * x
end

function expec(l)
    if length(l) > 0
        sum(l) / length(l)
    else
        0
    end
end

Celc = Table(CSV.File("Celcium.csv"))
farenheit = [Celc[i][1] for i in 1:6]
celcium = [Celc[i][2] for i in 1:6]

scatter(
    farenheit,
    celcium
)

f(x) = angle(celcium, farenheit) * x + norm(celcium, farenheit)

plot!(f)
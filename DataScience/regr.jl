using CSV, Plots, TypedTables

data = CSV.File("housingdata.csv")
X = data.size
Y = round.(Int, data.price / 1000)

t = Table(X = X, Y = Y)
gr(size = (600, 600))

scatter(X, Y, xlims = (0, 5000), ylims = (0, 800), xlabel = "Size", ylabel = "Price", legend = false)

E(X) = sum(X) / length(X)
function M(X, Y)
    ex = E(X)
    ey = E(Y)
    s1 = 0
    s2 = 0
    for (x, y) in [(X[i], Y[i]) for i in 1:length(X)]
        s1 += (x - ex)*(y)
        s2 += (x - ex)^2
    end
    s1/s2
end

k = M(X, Y)
b = E(Y) - k * E(X)
f(x) = k*x + b
plot!(f)

epochs = 0
theta_0 = 0.0
theta_1 = 0.0

h(x) = theta_0 .+ theta_1 * x
plot!(h)

N = length(X)
function cost(X, Y)
    (1/(2*m)) * sum((h(X) - Y).^2)    
end
J = cost(X, Y)
J_history = []
push!(J_history, J)

function pd_theta_0(X, Y)
    (1/m) * sum((h(X) - Y))
end

function pd_theta_1(X, Y)
    (1/m) * sum((h(X) - Y) .* X)
end
alpha_0 = 0.09
alpha_1 = 0.00000008

theta_0_temp = pd_theta_0(X, Y)
theta_1_temp = pd_theta_1(X, Y)

theta_0 -= alpha_0 * theta_0_temp
theta_1 -= alpha_1 * theta_1_temp

cost(X, Y)

plot!(h)

function κ(n) 
    a = 1
    i = 1
    while true
        b = modf(i*n)[1]
        if b != 0
            a *= b
        else
            break
        end
        i += 1
    end
    a
end

x = []
for i in 1:16
    append!(x, range(0, 1, i+1))
end
sort(x)
y = κ.(x)

plot(x, y)
savefig("XTest.svg")
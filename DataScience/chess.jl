using CSV
using TypedTables

Pref = Table(CSV.File("Preference.csv"))

temp = [Pref[i][1] for i in 1:10]
wind = [Pref[i][2] for i in 1:10]
sun = [Pref[i][3] for i in 1:10]
play = [Pref[i][4] for i in 1:10]

P_play = count(i -> (i=="yes"), play) / 10

function cond(arr, c)
    l=[]
    for i in 1:10
        if arr[i] == c
            push!(l, i)
        end
    end
    l
end

function Pcond(arr1, c1, arr2, c2)
    count(i -> (arr2[i] == c2 && i in cond(arr1, c1)), 1:10)
end



P_warm_play = Pcond(play, "yes", temp, "warm") / (P_play*10)
P_strong_play = Pcond(play, "yes", wind, "strong") / (P_play*10)
P_sunny_play = Pcond(play, "yes", sun, "sunny") / (P_play*10)
P_warm_notplay = Pcond(play, "no", temp, "warm") / ((1-P_play)*10)
P_strong_notplay = Pcond(play, "no", wind, "strong") / ((1-P_play)*10)
P_sunny_notplay =  Pcond(play, "no", sun, "sunny") / ((1-P_play)*10)

R = P_warm_play * P_strong_play * P_sunny_play * P_play
R_ = P_warm_notplay * P_strong_notplay * P_sunny_notplay * (1-P_play)

P = R/(R+R_) 
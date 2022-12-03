using BenchmarkTools

function get_score_part1(game::Vector{Int})
    if game[1] == game[2]
        return 3 + game[2]
    elseif mod(game[2], 3) == game[1] - 1
        return game[2]
    else
        return 6 + game[2]
    end
end

function get_score_part2(game::Vector{Int})
    if game[2] == 1
        return mod(game[1] + 1, 3) + 1
    elseif game[2] == 2
        return 3 + game[1]
    else
        return 6 + mod(game[1], 3) + 1
    end
end

function solve()
    input_file = open("./data/day2.txt") do file
        read(file, String)
    end
    games = [only.(split(game, " ")) for game in split(rstrip(input_file), "\n")]
    games_num = [mod.((Int.(game) .- 64), 23) for game in games]

    return sum(get_score_part1.(games_num)), sum(get_score_part2.(games_num))
end

println(solve())
@btime solve()

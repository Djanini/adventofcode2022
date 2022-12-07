using BenchmarkTools

function solve()
    input_file = open("./data/day7.txt") do file
        read(file, String) |> rstrip
    end
    return input_file
end

println(solve())
@btime solve()

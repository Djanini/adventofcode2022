using BenchmarkTools

function solve()
    input_file = open("./data/day6.txt") do file
        read(file, String) |> rstrip
    end
    return input_file
end

println(solve())
@btime solve()

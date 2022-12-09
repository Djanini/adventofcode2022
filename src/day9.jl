using BenchmarkTools

function solve()
    input_file::String = open("./data/day9.txt") do file
        read(file, String) |> rstrip
    end
    return input_file
end

println(solve())
@btime solve()

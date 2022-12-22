using BenchmarkTools

function solve()
    input_file::String = open("./data/day22.txt") do file
        read(file, String) |> rstrip
    end
    return input_file
end

println(solve())
@btime solve()

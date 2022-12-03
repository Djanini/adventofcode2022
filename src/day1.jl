using BenchmarkTools

function solve()
    input_file = open("./data/day1.txt") do file
        read(file, String)
    end
    totals = [sum(parse.(Int, split(elf))) for elf in split(input_file, "\n\n")]
    partialsort!(totals, 1:3, rev=true)
    return totals[1], sum(totals[1:3])
end

println(solve())
@btime solve()

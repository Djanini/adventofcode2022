using BenchmarkTools

function solve_day1()
    input_file = open("./data/day1.txt") do file
        read(file, String)
    end

    totals = partialsort([sum(parse.(Int, split(elf))) for elf in split(input_file, "\n\n")], 1:3, rev=true)
    return totals[1], sum(totals[1:3])
end

println(@btime solve_day1())

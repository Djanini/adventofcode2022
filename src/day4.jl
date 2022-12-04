using BenchmarkTools

function parse_pair(pair)
    return [range(parse.(Int, task)...) for task in split.(pair, "-")]
end


function pair_fully_contains(pair::Vector{UnitRange{Int64}})
    return pair[1] ⊆ pair[2] || pair[2] ⊆ pair[1]
end

function pair_overlaps(pair::Vector{UnitRange{Int64}})
    return length(pair[1] ∩ pair[2]) != 0
end

function solve()
    input_file = open("./data/day4.txt") do file
        read(file, String)
    end
    pairs = parse_pair.(split.(split(rstrip(input_file), "\n"), ","))

    return sum(pair_fully_contains.(pairs)), sum(pair_overlaps.(pairs))
end

println(solve())
@btime solve()

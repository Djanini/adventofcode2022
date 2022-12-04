using BenchmarkTools

parse_pair(pair::Vector{SubString{String}}) = [range(parse.(Int, task)...) for task in split.(pair, "-")]
pair_fully_contains(pair::Vector{UnitRange{Int64}}) = return pair[1] ⊆ pair[2] || pair[2] ⊆ pair[1]
pair_overlaps(pair::Vector{UnitRange{Int64}}) = length(pair[1] ∩ pair[2]) != 0

function solve()
    input_lines = open("./data/day4.txt") do file
        read(file, String) |> rstrip |> split
    end
    pairs = split.(input_lines, ",") .|> parse_pair
    return (pair_fully_contains.(pairs), pair_overlaps.(pairs)) .|> sum
end

println(solve())
@btime solve()

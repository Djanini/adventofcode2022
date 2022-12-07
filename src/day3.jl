using BenchmarkTools

get_value(letter_ord::Int) = letter_ord > 96 ? letter_ord - 96 : letter_ord - 38
calculate_score(letters::Vector{Char}) = sum(get_value.(Int.(letters)))

function solve()
    input_lines = open("./data/day3.txt", "r") do file
        read(file, String) |> rstrip |> split
    end

    items_in_both = input_lines .|> l -> intersect(l[1:end÷2], l[end÷2+1:end])[1]

    groups = [input_lines[i:i+2] for i ∈ 1:3:length(input_lines)]
    common_items = [intersect(group...)[1] for group ∈ groups]

    return calculate_score(items_in_both), calculate_score(common_items)
end

println(solve())
@btime solve()
using BenchmarkTools

function calculate_score(letters::Vector{Char})
    total_val = 0
    for ascii_val in Int16.(letters)
        if ascii_val > 96
            total_val += ascii_val - 96
        else
            total_val += ascii_val - 38
        end
    end
    return total_val
end

function solve()
    input_string = open("./data/day3.txt", "r") do file
        read(file, String)
    end
    lines = split(rstrip(input_string), "\n")

    items_in_both = Vector{Char}()
    for line in lines
        half = Int(length(line) / 2)
        append!(items_in_both, intersect(line[1:half], line[half+1:end])[1])
    end
    groups = [lines[i:i+2] for i in 1:3:length(lines)]
    common_items = [intersect(group...)[1] for group in groups]


    return calculate_score(items_in_both), calculate_score(common_items)
end

println(solve())
@btime solve()
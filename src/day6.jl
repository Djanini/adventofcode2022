using BenchmarkTools

function solve()
    input_string::String = open("./data/day6.txt") do file
        read(file, String) |> rstrip
    end

    function find_unique_characters(n::Int)::Int
        for i in 1:length(input_string)-n+1
            if length(Set(input_string[i:i+n-1])) == n
                return i + n - 1
            end
        end
    end

    return find_unique_characters(4), find_unique_characters(14)
end

println(solve())
@btime solve()
using BenchmarkTools

function solve()
    input_string::String = open("./data/day6.txt") do file
        read(file, String) |> rstrip
    end

    start_of_packet::Int = 0
    start_of_message::Int = 0

    for i in 1:length(input_string)-3
        if length(Set(input_string[i:i+3])) == 4
            start_of_packet = i + 3
            break
        end
    end
    for i in 1:length(input_string)-13
        if length(Set(input_string[i:i+13])) == 14
            start_of_message = i + 13
            break
        end
    end

    return start_of_packet, start_of_message
end

println(solve())
@btime solve()
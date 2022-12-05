using BenchmarkTools

Base.reverse!(x::Char) = x
do_move_cm9000!(crates::Vector{Vector{Char}}, move::Vector{Int}) = prepend!(crates[move[3]], splice!(crates[move[2]], 1:move[1]) |> reverse!)
do_move_cm9001!(crates::Vector{Vector{Char}}, move::Vector{Int}) = prepend!(crates[move[3]], splice!(crates[move[2]], 1:move[1]))

function parse_moves(move_data::SubString{String})
    moves_char = collect.(eachmatch.(r"\d+", split(rstrip(move_data), "\n")))
    return [map(m -> parse(Int, m.match), move) for move in moves_char]
end

function parse_crates(crate_data::SubString{String})
    crate_lines = split(crate_data, "\n")
    stacks_num = parse.(Int, crate_lines[end] |> rstrip |> split)
    crates::Vector{Vector{Char}} = [[] for i in stacks_num]
    for line in crate_lines[1:end-1]
        for stack in stacks_num
            crate = line[2+(stack-1)*4]
            if crate != ' '
                append!(crates[stack], crate)
            end
        end
    end
    return crates
end


function solve()
    crate_data, move_data = open("./data/day5.txt") do file
        read(file, String) |> rstrip |> x -> split(x, "\n\n")
    end

    crates9000 = parse_crates(crate_data)
    crates9001 = deepcopy(crates9000)
    moves = parse_moves(move_data)

    do_move_cm9000!.((crates9000,), moves)
    do_move_cm9001!.((crates9001,), moves)

    return getindex.(crates9000, 1), getindex.(crates9001, 1)
end

println(solve())
@btime solve()

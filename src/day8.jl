using BenchmarkTools

function num_visible_trees(trees::Matrix{Int})::Int
    visible::Matrix{Bool} = falses(size(trees))
    rows::Int, cols::Int = size(trees)
    for row in 1:rows, col in 1:cols
        tree::Int = trees[row, col]
        visible[row, col] = !all([
            any((trees[1:row-1, col]) .≥ tree),
            any((trees[row+1:end, col]) .≥ tree),
            any((trees[row, 1:col-1]) .≥ tree),
            any((trees[row, col+1:end]) .≥ tree)
        ])
    end
    return sum(visible)
end

function viewing_score_row(row::Vector{Int}, index::Int)::Int
    blocking::Vector{Bool} = row .≥ row[index]
    left::Union{Int,Nothing} = findfirst(blocking[index-1:-1:1])
    right::Union{Int,Nothing} = findfirst(blocking[index+1:end])
    return (left !== nothing ? left : index - 1) * (right !== nothing ? right : length(row) - index)
end

function solve()::Tuple{Int,Int}
    input_vectors::Vector{Matrix{Int}} = open("./data/day8.txt") do file
        read(file, String) |> rstrip |> split .|> collect .|> c -> permutedims(parse.(Int, c))
    end
    trees::Matrix{Int} = reduce(vcat, input_vectors)

    rows::Int, cols::Int = size(trees)
    score::Matrix{Int} = zeros(Int, size(trees))
    for row in 2:rows-1, col in 2:cols-1
        score[row, col] = Int(viewing_score_row(trees[row, :], col) * viewing_score_row(trees[:, col], row))
    end

    return num_visible_trees(trees), maximum(score)
end

println(solve())
@btime solve()
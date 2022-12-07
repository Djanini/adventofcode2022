using BenchmarkTools

function solve()
    input_string = open("./data/day7.txt") do file
        read(file, String) |> rstrip
    end
    input_lines::Vector{Vector{String}} = replace(input_string,
        "\$ cd .." => "dir_up,",
        r"\$ cd (\w+?)" => s"cd_to,\1",
        r"(\d+?) .*" => s"add_size,\1",
        r"((dir \w+)|(\$ ls)|(\$ cd /))\n" => "") |>
                                          lines -> split(lines, "\n") .|>
                                                   line -> split(line, ',')

    cmd_functions = Dict([
        "add_size" => (paths, dirsizes, size) -> mergewith!(+, dirsizes, Dict(path => parse(Int, size) for path ∈ paths)),
        "cd_to" => (paths, dirsizes, dir) -> push!(paths, paths[end] * "/" * dir),
        "dir_up" => (paths, dirsizes, _) -> pop!(paths)
    ])

    paths::Vector{String} = ["/"]
    dirsizes = Dict{String,Int}()

    for (cmd, arg) ∈ input_lines
        cmd_functions[cmd](paths, dirsizes, arg)
    end

    sizes_arr::Vector{Int} = collect(values(dirsizes))
    return sum(filter(s -> s ≤ 100_000, sizes_arr)), minimum(filter(s -> s ≥ dirsizes["/"] - 40_000_000, sizes_arr))
end

println(solve())
# @btime solve()
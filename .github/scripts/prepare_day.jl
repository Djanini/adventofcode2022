using HTTP

function prepare_code_file(d::Int)
    touch("./src/day$d.jl")
    boilerplate = open("./.github/scripts/boilerplate.jl", "r") do file
        replace(read(file, String), "dayx" => "day$d")
    end
    open("./src/day$d.jl", "w") do file
        write(file, boilerplate)
    end
end

function prepare_input_data(d::Int, session_cookie::String)
    cookies = Dict("session" => session_cookie)
    input_data = String(HTTP.get("https://adventofcode.com/2022/day/$d/input", cookies=cookies).body)
    touch("./data/day$d.txt")
    open("./data/day$d.txt", "w") do file
        write(file, input_data)
    end
end

function prepare_day(day::Int, session_cookie::String)
    println("Preparing input and code files for day $day.")
    prepare_code_file(day)
    prepare_input_data(day, session_cookie)
end

prepare_day(parse(Int, ARGS[1]), ARGS[2])
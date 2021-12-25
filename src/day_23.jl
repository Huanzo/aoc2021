include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe

function prepare_input(input)
	zip(match(r"(\w)", input[3]).captures, match(r"(\w)", input[4]).captures)
end

function p1(input::Vector{String})
rooms = prepare_input(input)
@info rooms
end

function p2(input::Vector{String})
end

@aoc(2021, 23)

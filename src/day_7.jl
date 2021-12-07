include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe


function p1(input::Vector{String})
	pos = @pipe split(input[1], ",") |> parse.(Int, _)
	return minimum([ sum(abs.(i .- pos)) for i in minimum(pos):maximum(pos) ])
end

function p2(input::Vector{String})
	pos = @pipe split(input[1], ",") |> parse.(Int, _)
	return minimum([ sum(sum.(range.(1, abs.(i .- pos); step = 1))) for i in minimum(pos):maximum(pos) ])
end

@aoc(2021, 7)

include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe


function solve(input::Vector{String}, days::Int64)
	fish = @pipe split(input[1], ",") |> parse.(Int, _)
	state = Dict{Int, Int}([ [x, count(==(x), fish)] for x in 0:8 ])

	for _ in 1:days
		next_day = Dict{Int, Int}([ [x, 0] for x in 0:8 ])
		next_day[8] = next_day[6] = state[0]
		for i in 0:7
			next_day[i] += state[i+1]
		end
		state = next_day
	end
	return sum(values(state))
end

function p1(input::Vector{String})
	return solve(input, 80)
end

function p2(input::Vector{String})
	return solve(input, 256)
end

@aoc(2021, 6)

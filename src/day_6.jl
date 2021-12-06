include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe


function solve(input, days)
	fish = @pipe split(input[1], ",") |> parse.(Int, _)
	state = Dict{Int, Int}([ [x, 0] for x in 0:8 ])

	for f in fish
		state[f] += 1
	end
	
	for d in 1:days
		next_day = Dict{Int, Int}([ [x, 0] for x in 0:8 ])
		next_day[8] = get(state, 0, 0)
		next_day[6] = get(state, 0, 0)
		for i in 0:7
			k = get(state, i+1, 0)
			next_day[i] += k
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

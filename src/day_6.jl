include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe


function p1(input::Vector{String})
	fish = @pipe split(input[1], ",") |> parse.(Int, _)
	for d in 1:80
		for f in 1:length(fish)
			if fish[f] == 0
				fish[f] = 6
				push!(fish, 8)
			else
				fish[f] -= 1
			end
		end
	end
	return length(fish)
end


function p2(input::Vector{String})
	fish = @pipe split(input[1], ",") |> parse.(Int, _)
	state = Dict{Int, Int}()
	fish = [3,4,3,1,2]

	for f in fish
		haskey(state, f) ? (state[f] += 1) : (state[f] = 1)
	end
	@info state
	
	for d in 1:256
		next_day = Dict{Int, Int}([ [x, 0] for x in 0:8 ])
		next_day[8] = get(state, 0, 0)
		next_day[6] = get(state, 0, 0)
		for i in 0:7
			k = get(state, i+1, 0)
			next_day[i] += k
		end
		state = next_day
	end
	return length(values(state))
end

@aoc(2021, 6)

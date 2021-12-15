include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe

function sliding(in, w::Int64; step::Int = 1)
	((@view in[i:i+w-1]) for i in 1:step:length(in)-w+1)
end

function prep_input(input)
	pairs = Dict()
	for pair in sliding(input[1], 2)
		!haskey(pairs, pair) ? (pairs[pair] = 0) : nothing
		pairs[pair] += 1
	end

	dict = Dict()
	for l in input[3:end]
		p, t = split(l, " -> ")
		dict[p] = (p[1] * t, t * p[2])
	end
	return (pairs, dict)
end

function step(pairs, dict)
	new = Dict()
	for pair in keys(pairs)
		p1, p2 = dict[pair]
		new[p1] = get(new, p1, 0) + pairs[pair]
		new[p2] = get(new, p2, 0) + pairs[pair]
	end
	return new
end

function solve(pairs, dict, rounds, last)
	for _ in 1:rounds
		pairs = step(pairs, dict)
	end

	c = Dict()
	for p in keys(pairs)
		!haskey(c, p[1]) ? (c[p[1]] = 0) : nothing
		c[p[1]] += pairs[p]
	end
	c[last] += 1 # add one more count for last character in polymer
	return maximum(values(c)) - minimum(values(c))
end

function p1(input::Vector{String})
	pairs, dict = prep_input(input)
	return solve(pairs, dict, 10, input[begin][end])
end

function p2(input::Vector{String})
	pairs, dict = prep_input(input)
	return solve(pairs, dict, 40, input[begin][end])
end

@aoc(2021, 14)

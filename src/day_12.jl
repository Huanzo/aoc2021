include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe

function visit(map, curr_cave, visited)
	curr_cave == "end" ? (return 1) : nothing
	curr_cave[begin] in 'a':'z' && curr_cave ∈ visited ? (return 0) : nothing

	v = copy(visited)
	push!(v, curr_cave)
	return sum([ visit(map, e, v) for e in map[curr_cave] ])
end

function visit2(map, curr_cave, visited, d)
	curr_cave == "end" ? (return 1) : nothing
	curr_cave == "start" && length(visited) != 0 ? (return 0) : nothing
	if curr_cave[begin] in 'a':'z' && curr_cave ∈ visited
		d == nothing ? (d = curr_cave) : (return 0)
	end
	v = copy(visited)
	push!(v, curr_cave)
	return sum([ visit2(map, e, v, d) for e in map[curr_cave] ])
end

function prepare_input(input)
	map = Dict()
	for l in input
		a, b = split(l, "-")
		!haskey(map, a) ? (map[a] = [b]) : (push!(map[a], b))
		!haskey(map, b) ? (map[b] = [a]) : (push!(map[b], a))
	end
	return map
end

function p1(input::Vector{String})
	return visit(prepare_input(input), "start", [])
end

function p2(input::Vector{String})
	return visit2(prepare_input(input), "start", [], nothing)
end

@aoc(2021, 12)

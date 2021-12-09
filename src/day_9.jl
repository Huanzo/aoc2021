include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe
using Combinatorics


function p1(input::Vector{String})
	map = []
	for l in input
		push!(map, [ parse(Int, c) for c in l ])
	end
	risks = 0
	for x in 1:length(map)
		for y in 1:length(map[1])
			adjacent = []
			for (a,b) in [[0,1], [1,0], [0,-1], [-1,0]]
				i = x + a
				j = y + b

				if i < 1 || i > length(map) || j < 1 || j > length(map[1])
					continue
				end
				push!(adjacent, map[i][j])
			end
			@info map[x][y]
			@info adjacent
			if map[x][y] < minimum(adjacent)
				@info "low"
				risks += map[x][y] + 1
			end
		end
	end
	return risks
end

function lowpoints(map)
	low = []
	for x in 1:length(map)
		for y in 1:length(map[1])
			adjacent = []
			for (a,b) in [[0,1], [1,0], [0,-1], [-1,0]]
				i = x + a
				j = y + b

				if i < 1 || i > length(map) || j < 1 || j > length(map[1])
					continue
				end
				push!(adjacent, map[i][j])
			end
			if map[x][y] < minimum(adjacent)
				push!(low, [x,y])
			end
		end
	end
	return low
end

function search(map, pos)
	queue = [pos]
	visited = [pos]

	while length(queue) > 0
		c = popfirst!(queue)
		h = map[c[1], c[2]]
		for pos in [ [x+i,y+j] for (i,j) in zip([0,1,0,-1], [1,0,-1,0]) ]
			if p[1] < 1 || p[1] > length(map) || p[2] < 1 || p[2] > length(map[1])
				continue
			end
			if pos ∉ visited
				h2 = map[p[1]][p[2]]
				if h2 < 9 && h2 > h
					push!(visited, pos)
					push!(queue, pos)
				end
			end
		end
	end
	return visited
end

function p2(input::Vector{String})
	map = []
	for l in input
		push!(map, [ parse(Int, c) for c in l ])
	end
	low = lowpoints(map)
	basin_sizes = [ length(search(map, p)) for p in low ]
	return prod(sort(basin_sizes)[end-2:end])
end

@aoc(2021, 9)

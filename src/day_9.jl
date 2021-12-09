include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe
using Combinatorics


function lowpoints(map)
	low = Dict()
	for x in 1:length(map)
		for y in 1:length(map[1])
			adjacent = []
			for (i,j) in [ [x+i,y+j] for (i,j) in zip([0,1,0,-1], [1,0,-1,0]) ]
				if i in 1:length(map) && j in 1:length(map[1])
					push!(adjacent, map[i][j])
				end
			end
			if map[x][y] < minimum(adjacent)
				low[[x,y]] = map[x][y]
			end
		end
	end
	return low
end

function p1(input::Vector{String})
	map = [ parse.(Int, collect(l)) for l in input ]
	low = lowpoints(map)
	return sum(values(low)) + length(low)
end


function search(map, pos)
	q = [pos]
	v = [pos]

	while length(q) > 0
		c = popfirst!(q)
		h = map[c[1]][c[2]]
		for p in [ [c[1]+i,c[2]+j] for (i,j) in zip([0,1,0,-1], [1,0,-1,0]) ]
			if p[1] in 1:length(map) && p[2] in 1:length(map[1])
				if p ∉ v
					h2 = map[p[1]][p[2]]
					if h < h2 < 9
						push!(v, p)
						push!(q, p)
					end
				end
			end
		end
	end
	return v
end

function p2(input::Vector{String})
	map = [ parse.(Int, collect(l)) for l in input ]
	low = lowpoints(map)
	basin_sizes = [ length(search(map, p)) for p in keys(low) ]
	return prod(sort(basin_sizes)[end-2:end])
end

@aoc(2021, 9)

include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe
using Graphs, SimpleWeightedGraphs

function prep_input(input)
	[ parse.(Int, collect(l)) for l in input ]
end

function lowest_cost(grid)
	q = [(1,1,0)]
	costs = Dict()
	while true
		x,y,c = popfirst!(q)
		x == length(grid) && y == length(grid[1]) ? (return c) : nothing
		for (x2, y2) in [(x+1,y),(x-1,y),(x,y-1),(x,y+1)]
			if x2 in 1:length(grid) && y2 in 1:length(grid[1])
				cost = c + grid[x2][y2]
				(x2, y2) in keys(costs) && costs[(x2, y2)] <= cost ? (continue) : nothing
				costs[(x2, y2)] = cost
				push!(q, (x2, y2, cost))
			end
		end
		sort!(q)
	end
end

function p1(input::Vector{String})
	grid = prep_input(input)
	return lowest_cost(grid)
end

function p2(input::Vector{String})
	grid = prep_input(input)
	newgrid = [ zeros(Int, 5*length(grid[1])) for _ in 1:5*length(grid) ]

	for x in 1:length(newgrid), y in 1:length(newgrid[1])
		v = grid[x%length(grid)+1][y%length(grid[1])+1]
		for _ in 1:((x-1) ÷ length(grid) + (y-1) ÷ length(grid[1])) # ÷ performs integer division
			v + 1 == 10 ? (v = 1) : (v += 1)
		end
		newgrid[x][y] = v
	end
	return lowest_cost(newgrid)
end

@aoc(2021, 15)

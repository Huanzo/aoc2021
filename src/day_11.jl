include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe
using Combinatorics


function step(map, copy, x, y)
	level = copy[x][y] = map[x][y] + 1
	if level == 10
		global flahes = flashes + 1
		for (x,y) in zip([-1,0,1,-1,1,-1,0,1], [1,1,1,0,0,-1,-1,-1])
			if x in 1:length(map) && y in 1:length(map[1])
				step(map, copy, x, y)
			end
		end
	end
end

function solve(input, part)
	map = [ parse.(Int, collect(l)) for l in input ]
	elements = length(map) * length(map[1])
	sum = 0
	step = 0

	while true
		step += 1
		flash = []
		flashed = []
		for x in 1:length(map)
			for y in 1:length(map[1])
				map[x][y] += 1
				if map[x][y] > 9
					push!(flash, [x,y])
					push!(flashed, [x,y])
				end
			end
		end
		while length(flash) != 0
			x, y = pop!(flash)
			for (i,j) in zip([-1,0,1,-1,1,-1,0,1], [1,1,1,0,0,-1,-1,-1])
				nx = x + i
				ny = y + j
				if nx in 1:length(map) && ny in 1:length(map[1])
					map[nx][ny] += 1
					if map[nx][ny] > 9 && [nx, ny] ∉ flashed
						push!(flash, [nx,ny])
						push!(flashed, [nx,ny])
					end
				end
			end
		end

		for (x,y) in flashed
			map[x][y] = 0
		end

		sum += length(flashed)

		if part == 1 && step == 100
			break
		end

		if part == 2 && length(unique(flashed)) == elements
			return step
		end
	end
	return sum
end

function p1(input::Vector{String})
	solve(input, 1)
end

function p2(input::Vector{String})
	solve(input, 2)
end

@aoc(2021, 11)

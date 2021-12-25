include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe
using Memoization

function p1(input::Vector{String})
	grid =  [ collect(l) for l in input]
	steps = 0
	while true
		steps += 1
		moved = false
		tmp = deepcopy(grid)
		for y in 1:length(grid), x in 1:length(grid[1])
			if grid[y][x] == '>' && grid[y][x%length(grid[1])+1] == '.'
					moved = true
					tmp[y][x%length(grid[1])+1] = '>'
					tmp[y][x] = '.'
			end
		end
		tmp2 = deepcopy(tmp)
		for y in 1:length(tmp), x in 1:length(grid[1])
			if tmp[y][x] == 'v' && tmp[y%length(grid)+1][x] == '.'
					moved = true
				tmp2[y%length(grid)+1][x] = 'v'
					tmp2[y][x] = '.'
			end
		end
		!moved && (return steps)
		grid = tmp2
	end
end

function p2(input::Vector{String})
	"Day 25 has no Part 2"
end

@aoc(2021, 25)

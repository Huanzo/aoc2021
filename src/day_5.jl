include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe

function parse_line(input)
	c = match(r"(\d+),(\d+) -> (\d+),(\d+)", input).captures
	return parse.(Int, c)
end

function p1(input::Vector{String})
	board = Dict{Tuple{Int64, Int64}, Int64}()
	for l in input
		p = parse_line(l)
		if p[1] == p[3] || p[2] == p[4]
			xstep = p[1] > p[3] ? -1 : 1
			ystep = p[2] > p[4] ? -1 : 1
			for x in p[1]:xstep:p[3]
				for y in p[2]:ystep:p[4]
					(x,y) in keys(board) ? (board[(x,y)] += 1) : (board[(x,y)] = 1)
				end
			end
		end
	end
	return count(>=(2), values(board))
end


function p2(input::Vector{String})
	board = Dict{Tuple{Int64, Int64}, Int64}()
	for l in input
		p = parse_line(l)
		if p[1] == p[3] || p[2] == p[4]
			xstep = p[1] > p[3] ? -1 : 1
			ystep = p[2] > p[4] ? -1 : 1
			for x in p[1]:xstep:p[3]
				for y in p[2]:ystep:p[4]
					(x,y) in keys(board) ? (board[(x,y)] += 1) : (board[(x,y)] = 1)
				end
			end
		elseif abs(p[1] - p[3]) == abs(p[2] - p[4])
			xstep = p[1] > p[3] ? -1 : 1
			ystep = p[2] > p[4] ? -1 : 1
			for(x,y) in zip(p[1]:xstep:p[3], p[2]:ystep:p[4])
				(x,y) in keys(board) ? (board[(x,y)] += 1) : (board[(x,y)] = 1)
			end
		end
	end
	return count(>=(2), values(board))
end

@aoc(2021, 5)

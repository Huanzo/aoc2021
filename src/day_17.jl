include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe

function solve(input)
	x1, x2, y1, y2 = parse.(Int, match(r"target area: x=(-?\d+)..(-?\d+), y=(-?\d+)..(-?\d+)", input).captures)
	total = 0
	best = 0
	for vx in isqrt(2x1)+1:x2, vy in y1:abs(y1)
		x,y,maxy = 0,0,0
		Δx, Δy = vx, vy
		found = passed = false
		while true
			inside = false
			x += Δx; y += Δy
			Δx -= sign(Δx); Δy -= 1
			y > maxy && (maxy = y)
			if x in x1:x2 && y in y1:y2
				inside = true
				!found && (total += 1); found = true
				maxy > best  && (best = maxy)
			end
			(found && !inside) && break
			y < y1 && break
		end
	end
	return (best, total)
end

function p1(input::Vector{String})
	return solve(input[1])[1]
end

function p2(input::Vector{String})
	return solve(input[1])[2]
end

@aoc(2021, 17)

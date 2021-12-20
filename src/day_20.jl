include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe

function prepare_input(input)
	code = [ (c == '#') for c in input[1] ]
	image = []

	for l in input[3:end]
		push!(image, [ (c == '#') for c in l ])
	end
	code, image
end

function neighbours(i,j)
	( (i+y,j+x) for (y, x) in zip([-1,-1,-1,0,0,0,1,1,1], [-1,0,1,-1,0,1,-1,0,1]))
end

function get_value(image, y, x, bool)
	( 1 <= y <= length(image)  && 1 <= x <= length(image[1])) && return image[y][x]
	bool
end

function apply_alg(image, code, bool)
	w = length(image[1])
	h = length(image)
	newimage = []
	for y in 0:h+1
		row = []
		for x in 0:w+1
			values = [ get_value(image, y2, x2, bool) for (y2,x2) in neighbours(y, x)]
			idx = parse(Int, join(map(b->b ? 1 : 0, values)), base=2)
			push!(row, code[idx+1])
		end
		push!(newimage, row)
	end
	newimage
end

function p1(input::Vector{String})
	code, image = prepare_input(input)
	bool = false
	for _ in 1:2
		image = apply_alg(image, code, bool)
		bool = !bool
	end
	return sum(vcat(image...))
end

function p2(input::Vector{String})
	code, image = prepare_input(input)
	bool = false
	for _ in 1:50
		image = apply_alg(image, code, bool)
		bool = !bool
	end
	return sum(vcat(image...))
end

@aoc(2021, 20)

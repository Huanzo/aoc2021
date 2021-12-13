include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe

function fold(grid, dir, at)
	if dir == "x"
		new = grid[:, 1:at]
		rest = reverse(grid[:, at+2:end], dims=2)
	else
		new = grid[1:at, :]
		rest = reverse(grid[at+2:end, :], dims=1)
	end
	lnewx, lnewy = (length(new[1, :]), length(new[:, 1]))
	lrestx, lresty = (length(rest[1, :]), length(rest[:, 1]))
	for y in 1:lresty, x in 1:lrestx
		new[lnewy-lresty+y, lnewx-lrestx+x] = new[lnewy-lresty+y, lnewx-lrestx+x] || rest[y,x]
	end
	return new
end

function prep_input(input)
	folds = []
	holes = []
	for l in input
		if l == ""; continue; end
		m = match(r"(\d+),(\d+)",l)
		if m == nothing
			c = match(r"(\w)=(\d+)", l).captures
			push!(folds, [c[1], parse(Int, c[2])])
		else
			c = match(r"(\d+),(\d+)", l).captures
			push!(holes, [parse(Int, c[1]), parse(Int, c[2])])
		end
	end
	max_x = maximum(map(x-> x[1], holes))
	max_y = maximum(map(x-> x[2], holes))
	grid = falses((max_y+1, max_x+1))
	for (x,y) in holes
		grid[y+1,x+1] = true
	end
	return (grid, folds)
end

function print_grid(grid)
	for y in 1:length(grid[:,1])
		for x in 1:length(grid[1,:])
			print(".#"[grid[y,x]+1])
		end
		println("")
	end
end

function p1(input::Vector{String})
	grid, folds = prep_input(input)
	return sum(fold(grid, folds[1][1], folds[1][2]))
end

function p2(input::Vector{String})
	grid, folds = prep_input(input)
	for (dir, at) in folds
		grid = fold(grid, dir, at)
	end
	print_grid(grid)
end

@aoc(2021, 13)

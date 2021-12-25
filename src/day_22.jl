include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe

function prepare_input(input)
	out = []
	for l in input
		on = l[1:3] == "on "
		n = split(l, ",")
		cords = [ parse.(Int, match(r"(-?\d+)\.\.(-?\d+)", r).captures) for r in n ]
		push!(out, (on, cords))
	end
	out
end

function p1(input::Vector{String})
	list = prepare_input(input)
	dict = Dict()
	for (on, range) in list
		xmin = range[1][1] < -50 ? -50 : range[1][1]
		ymin = range[2][1] < -50 ? -50 : range[2][1]
		zmin = range[3][1] < -50 ? -50 : range[3][1]
		xmax = range[1][2] > 50 ? 50 : range[1][2]
		ymax = range[2][2] > 50 ? 50 : range[2][2]
		zmax = range[3][2] > 50 ? 50 : range[3][2]
		for x in xmin:xmax, y in ymin:ymax, z in zmin:zmax
			dict[(x,y,z)] = on
		end
	end
	return sum(collect(values(dict)))
end

function p2(input::Vector{String})
	list = prepare_input(input)
	cubes = []
	for (on, ((xmin, xmax),(ymin, ymax),(zmin, zmax))) in list
		for i in 1:length(cubes)
			(xmin2,xmax2,ymin2,ymax2,zmin2,zmax2) = cubes[i]
			if xmin > xmax2 || xmax < xmin2 || ymin > ymax2 || ymax < ymin2 ||zmin > zmax2 || zmax < zmin2
				# new cube does not intersect with the current one
				continue
			end
			# the new cube intersects the current cube, mark current cube for removal and divide it into smaller cubes that dont intersect the new cube
			cubes[i] = nothing # unset the element to keep positions constant fo ths step
			(xmin > xmin2) && push!(cubes, (xmin2          , xmin-1          , ymin2          , ymax2          , zmin2   , zmax2   ))
			(xmax < xmax2) && push!(cubes, (xmax + 1       , xmax2           , ymin2          , ymax2          , zmin2   , zmax2   ))
			(ymin > ymin2) && push!(cubes, (max(xmin,xmin2), min(xmax, xmax2), ymin2          , ymin - 1       , zmin2   , zmax2   ))
			(ymax < ymax2) && push!(cubes, (max(xmin,xmin2), min(xmax, xmax2), ymax + 1       , ymax2          , zmin2   , zmax2   ))
			(zmin > zmin2) && push!(cubes, (max(xmin,xmin2), min(xmax, xmax2), max(ymin,ymin2), min(ymax,ymax2), zmin2   , zmin - 1))
			(zmax < zmax2) && push!(cubes, (max(xmin,xmin2), min(xmax, xmax2), max(ymin,ymin2), min(ymax,ymax2), zmax + 1, zmax2   ))
		end
		on && push!(cubes, (xmin, xmax, ymin, ymax, zmin, zmax)) # Add cube if on
		filter!(!=(nothing), cubes) # delete the unset elements
	end
	sum([ (xmax-xmin+1) * (ymax-ymin+1) * (zmax-zmin+1) for (xmin,xmax,ymin,ymax,zmin,zmax) in cubes ])
end

@aoc(2021, 22)

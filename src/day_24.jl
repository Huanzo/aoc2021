include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe
using Memoization

function calc(i, w, z, add_x, add_y, div_z)
	x = add_x[i] + (z % 26)
	z = z ÷ div_z[i]
	x != w && (z = z * 26 + w + add_y[i])
	z
end

@memoize function find_solution(i, z, add_x, add_y, div_z)
	(i == 15 && z == 0) && return [""]
	i == 15 && return []

	x = add_x[i] + (z % 26)
	possible_numbers = collect(1:9)
	x in 1:9 && (possible_numbers = [x])
	out = []
	for num in possible_numbers
		nextz = calc(i, num, z, add_x, add_y, div_z)
		nextxs = find_solution(i + 1, nextz, add_x, add_y, div_z)
		for x2 in nextxs
			push!(out, string(num) * x2)
		end
	end
	out
end

function p1(input::Vector{String})
	add_x = []
	add_y = []
	div_z = []
	for (i, l) in enumerate(input)
		(contains(l, "add x") && !contains(l, "add x z")) && push!(add_x, parse(Int, split(l, " ")[3]))
		(contains(l, "add y") && ((i-1) % 18 == 15)) && push!(add_y, parse(Int, split(l, " ")[3]))
		contains(l, "div z") && push!(div_z, parse(Int, split(l, " ")[3]))
	end
	@info add_x
	@info add_y
	@info div_z
	solutions = [ parse(Int, s) for s in find_solution(1, 0, add_x, add_y, div_z) ]
	minimum(solutions), maximum(solutions), length(solutions)
end

function p2(input::Vector{String})
	"P2 solution is part of P1"
end

@aoc(2021, 24)

include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe
using Combinatorics

function addn(v, n, dir)
 	n == nothing && (return v)
	typeof(v) == Int && (return v+n)
	if dir == "left"
		return [addn(v[1], n, "left"), v[2]]
	else
		return [v[1], addn(v[2], n, "right")]
	end
end

function arrexplode(v, n = 4)
	typeof(v) == Int && (return (false, nothing, v, nothing))
	n == 0 && (return true, v[1], 0, v[2])

	l, r = v
	exploded, t, l, w = arrexplode(l, n-1)
	exploded && (return true, t, [l, addn(r, w, "left")], nothing)
	exploded, t, r, w = arrexplode(r, n-1)
	exploded && (return true, nothing, [addn(l, t, "right"), r], w)

	false, nothing, v, nothing
end

function arrsplit(v)
	if typeof(v) == Int
		v > 9 && (return true, [v ÷ 2, Int(round(v/2, RoundUp))])
		return false, v
	end
	l, r = v
	changed, l = arrsplit(l)
	changed && (return true, [l,r])
	changed, r = arrsplit(r)

	changed, [l,r]
end

function arradd(l, r)
	sum = [l,r]
	while true
		changed, t, sum, w = arrexplode(sum)
		changed && continue
		changed, sum = arrsplit(sum)
		changed && continue
		break
	end
	sum
end

function magn(v)
	typeof(v) == Int && (return v)
	3*magn(v[1]) + 2*magn(v[2])
end

function p1(input::Vector{String})
	numbers = [ eval(Meta.parse(x)) for x in input ]
	magn(reduce(arradd, numbers))
end

function p2(input::Vector{String})
	numbers = [ eval(Meta.parse(x)) for x in input ]
	maximum([magn(arradd(l,r)) for (l, r) in Combinatorics.permutations(numbers, 2)])
end

@aoc(2021, 18)

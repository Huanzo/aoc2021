include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe
using Combinatorics

function prepare_input(input)
	dict = []
	tmp = []
	for l in input
		l == "" && continue
		m = match(r"--- scanner (\d+) ---", l)
		if m != nothing
			length(tmp) != 0 && push!(dict, tmp)
			tmp = []
			continue
		end
		push!(tmp, parse.(Int, split(l, ",")))
	end
	dict
end

function align(a,b, negs, distances)
	a2 = Set(a)
	for re in 1:6, neg in negs
		newb = [ neg .* collect(Combinatorics.permutations(s,3))[re] for s in b ]
		for p1 in a2, p2 in newb
			count = 0
			remapped = []
			dist = p2 .- p1
			for b2 in newb
				to_a = b2 .- dist
				to_a in a2 && (count += 1)
				push!(remapped, to_a)
			end
			if count >= 12
				println("match $dist")
				push!(distances, dist)
				return true, remapped
			end
		end
	end
	return false, []
end

function p1(input::Vector{String})
	@info "Something is brken. This may take 5 minutes or more to get a slightly wrong result."
	negations = [
		[1,1,1],
		[-1,1,1],
		[1,-1,1],
		[1,1,-1],
		[-1,-1,1],
		[-1,1,-1],
		[-1,-1,-1],
		[1,-1,-1]
	]
	list = prepare_input(input)
	aligned_idx = Set(1)
	aligned = Dict(1 => list[1])
	beacons = copy(list[1])
	dont_align = Set()
	distances = [[0,0,0]]
	while length(aligned_idx) < length(list)
		for i in 1:length(list)
			i in aligned_idx && continue
			for j in sort(collect(aligned_idx))
				println("checking $i against $j")
				(i,j) in dont_align && continue
				found, remapped = align(aligned[j], list[i], negations, distances)
				if found
					push!(aligned_idx, i)
					aligned[i] = remapped
					beacons = vcat(beacons, remapped)
					break
				end
				push!(dont_align, (i,j))
			end
		end
	end
	return length(beacons)
end

function p2(input::Vector{String})
end

@aoc(2021, 19)

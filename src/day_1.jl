include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

function sliding(in, w)
	((@view in[i:i+w-1]) for i in 1:1:length(in)-w+1)
end

function day1(in, w)
	meassurements = parse.(Int, in)
	prev = sum(meassurements[begin:begin+w-1])
	c = 0
	for i ∈ sliding(meassurements, w)
		s = sum(i)
		s > prev && (c += 1)
		prev = s
	end
	c
end

function p1(input)
	day1(input, 1)
end


function p2(input)
	day1(input, 3)
end

@aoc(2021, 1)

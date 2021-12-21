include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe

function prepare_input(input)
	p1 = parse(Int, match(r"position: (\d)", input[1]).captures[1])
	p2 = parse(Int, match(r"position: (\d)", input[2]).captures[1])
	[p1, p2]
end

function p1(input::Vector{String})
	p = prepare_input(input)
	score = [0,0]
	d = 1
	while true
		for i in 1:2
			np = (p[i] + sum(d:d+2)) % 10 
			d += 3
			score[i] += p[i] = np
			score[i] >= 1000 && return (score[i==1 ? 2 : 1]*(d-1))
		end
	end
end

function simulate(position, score, mul, scores)
	length(scores) == 0 && return
	s = popfirst!(scores)
	for (throw, chances) in [(3, 1),(4, 3),(5, 6),(6, 7),(7, 6),(8, 3),(9, 1)]
		position2 = (position + throw) % 10
		score2 = score + (position2 == 0 ? 10 : position2)
		paths = mul * chances
		if score2 >= 21
			s[1] += paths
		else
			s[2] += paths
			simulate(position2, score2, paths, scores)
		end
	end
	pushfirst!(scores, s)
end

function p2(input::Vector{String})
	p = prepare_input(input)
	
	s1 = [ [0,0] for _ in 1:21 ]
	simulate(p[1], 0, 1, s1)
	s2 = [ [0,0] for _ in 1:21 ]
	simulate(p[2], 0, 1, s2)

	w1 = sum(map(x -> x[1][1] * x[2][2], zip(s1[2:end], s2)))
	w2 = sum(map(x -> x[1][1] * x[2][2], zip(s2, s1)))
	return w1 > w2 ? w1 : w2
end

@aoc(2021, 21)

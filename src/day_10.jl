include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe
using Combinatorics


function check_line(l, dict, scores)
		braces = []
		for b in l
			if b in keys(dict)
				push!(braces, b)
				continue
			end
			if length(braces) != 0 && b == dict[braces[end]]
				pop!(braces)
				continue
			else
			@info "found $b"
			t = braces[end]
			@info "should be $t"
				return scores[b]
			end
		end
		return 0
end

function p1(input::Vector{String})
	dict = Dict(
							'(' => ')',
							'[' => ']',
								'<' => '>',
												'{' => '}'
							)
	scores = Dict(
							')' => 3,
	']' => 57,
								'>' => 25137,
								'}' => 1197)
	sum = 0
	for l in input
		sum += check_line(l, dict, scores)
	end
	return sum
end

function corrupted(l, dict)
	braces = []
	for b in l
		if b in keys(dict)
			push!(braces, b)
			continue
		end
		if length(braces) != 0 && b == dict[braces[end]]
			pop!(braces)
			continue
		else
			return true
		end
	end
	return false
end

function complete(l, dict)
	braces = []
	for b in l
		if b in keys(dict)
			push!(braces, b)
			continue
		end
		if length(braces) != 0 && b == dict[braces[end]]
			pop!(braces)
			continue
		end
	end
	out = []
	for c in reverse(braces)
		push!(out, dict[c])
	end
	return out
end

function p2(input::Vector{String})
	dict = Dict(
							'(' => ')',
							'[' => ']',
								'<' => '>',
												'{' => '}'
							)
	scores = Dict(
							')' => 1,
							']' => 2,
							'}' => 3,
							'>' => 4)
	line_scores = []
	remaining = filter(x -> !corrupted(x, dict), input)
	a = [complete(x, dict) for x in remaining]
	out = []
	for e in a
		score = 0
		for c in e
			score = score * 5 + scores[c]
		end
		push!(out, score)
	end
	return sort(out)[convert(Int,round(length(out)/2, RoundUp))]
end

@aoc(2021, 10)

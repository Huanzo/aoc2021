include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe
using Combinatorics


function p1(input::Vector{String})
	count = 0
	for l in input
		digits = @pipe split(l, "|")[end] |> split(_, " ") |> filter(!=(""), _)
		for d in digits
			for i in [2,3,4,7]
				if length(d) == i
					count += 1
				end
			end
		end
	end
	return count
end

function get_digit(i, o, digits)
	for permutation in Combinatorics.permutations("abcdefg")
		dict = Dict([[x, y] for (x,y) in zip(permutation, "abcdefg")])
		if all([ x in keys(digits) for x in map(x -> (join(sort([dict[y] for y in x]))), i)])
			return parse(Int, join([ digits[join(sort([dict[y] for y in x]))] for x in o]))
		end
	end
end

function p2(input::Vector{String})
	sum = 0
	dict = Dict{String, Int}(
		"abcefg" => 0,
		"cf" => 1,
		"acdeg" => 2,
		"acdfg" => 3,
		"bcdf" => 4,
		"abdfg" => 5,
		"abdefg" => 6,
		"acf" => 7,
		"abcdefg" => 8,
		"abcdfg" => 9
	)
	for l in input
		i = @pipe split(l, "|")[begin] |> split(_, " ") |> filter(!=(""), _)
		o = @pipe split(l, "|")[end] |> split(_, " ") |> filter(!=(""), _)
		sum+=get_digit(i,o,dict)
	end
	return sum
end

@aoc(2021, 8)

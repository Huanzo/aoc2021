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

function p2(input::Vector{String})
	count = 0
	map = Dict{String, Int}(
													"abcdeg" => 0,
													"ab" => 1,
													"acdfg" => 2,
													"" => 0,
													"abcdeg" => 0,
													"abcdeg" => 0,
													"abcdeg" => 0,
													"abcdeg" => 0,
													"abcdeg" => 0,
													"abcdeg" => 0,
												 )
	for l in input
		dict = Dict{Char, Int}()
		i = @pipe split(l, "|")[begin] |> split(_, " ") |> filter(!=(""), _)
		o = @pipe split(l, "|")[end] |> split(_, " ") |> filter(!=(""), _)
		good = 
		for d in inputdigits
			if length(d) == 3
				find(==(3))
			end

		end
	end
end

@aoc(2021, 8)

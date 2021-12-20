include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe


function decode_packet(p, o, version)
	version += parse(Int, p[o:o+2], base=2); o+=3
	type = parse(Int, p[o:o+2], base = 2); o+=3

	if type == 4
		v = ""
		while true
			tmp = p[o:o+4]; o+=5
			v *= tmp[2:end]
			tmp[1] == '0' ? break : continue
		end
		value = parse(Int, v, base=2)
	else
		length_type = p[o]; o+=1
		sub_values = []
		if length_type == '0'
			length = parse(Int, p[o:o+14], base=2); o+=15
			target = o + length
			while o < target
				v, o, version = decode_packet(p, o, version)
				push!(sub_values, v)
			end
		else
			num = parse(Int, p[o:o+10], base=2); o+=11
			for _ in 1:num
				v, o, version = decode_packet(p, o, version)
				push!(sub_values, v)
			end
		end
	end
	
	if type == 0
		value = sum(sub_values)
	elseif type == 1 
		value = prod(sub_values)
	elseif type == 2
		value = minimum(sub_values)
	elseif type == 3
		value = maximum(sub_values)
	elseif type == 5
		value = sub_values[begin] > sub_values[end] ? 1 : 0
	elseif type == 6
		value = sub_values[begin] < sub_values[end] ? 1 : 0
	elseif type == 7
		value = sub_values[begin] == sub_values[end] ? 1 : 0
	end
	return (value, o, version)
end

function p1(input::Vector{String})
	packet = ""
	for c in input[1]
		packet *= bitstring(Int8(parse(Int, c, base = 16)))[5:end]
	end
	v, _, version = decode_packet(packet, 1, 0)
	return version
end

function p2(input::Vector{String})
	packet = ""
	for c in input[1]
		packet *= bitstring(Int8(parse(Int, c, base = 16)))[5:end]
	end
	v, _ = decode_packet(packet, 1, 0)
	return v
end

@aoc(2021, 16)

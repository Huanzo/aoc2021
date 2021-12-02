include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

function sliding(in, w::Int64; step::Int = 1)
  ((@view in[i:i+w-1]) for i in 1:step:length(in)-w+1)
end


function p1(input::Vector{String})
  d = [0, 0]
  for i ∈ input
    c = match(r"(\w+)\s(\d+)", i).captures
    if c[1] == "forward"
      d[1] += parse(Int, c[2])
    elseif c[1] == "down"
      d[2] += parse(Int, c[2])
    elseif c[1] == "up"
      d[2] -= parse(Int, c[2])
    end
  end
  prod(d)
end


function p2(input::Vector{String})
  d = [0, 0, 0]
  for i ∈ input
    c = match(r"(\w+)\s(\d+)", i).captures
    if c[1] == "forward"
      d[1] += parse(Int, c[2])
      d[2] += parse(Int, c[2]) * d[3]
    elseif c[1] == "down"
      d[3] += parse(Int, c[2])
    elseif c[1] == "up"
      d[3] -= parse(Int, c[2])
    end
  end
  prod(d[1:2])
end

@aoc(2021, 2)

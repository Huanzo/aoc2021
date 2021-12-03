include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc


function p1(input::Vector{String})
  γ = ""
  ϵ = ""
  for n in 1:length(input[1])
    bits = map(x -> parse(Int, x[n]), input)
    more_ones = sum(bits) > length(bits) / 2
    γ *= more_ones ? "1" : "0"
    ϵ *= more_ones ? "0" : "1"
  end
  parse(Int, γ; base=2) * parse(Int, ϵ; base=2)
end


function p2(input::Vector{String})
  i1 = copy(input)
  i2 = copy(input)
  ox = ""
  co = ""
  for i in 1:length(input[1])
    oxbits = map(x -> parse(Int, x[i]), i1)
    cobits = map(x -> parse(Int, x[i]), i2)
    
    oxmc = sum(oxbits) >= length(oxbits) / 2 ? '1' : '0'
    comc = sum(cobits) >= length(cobits) / 2 ? '0' : '1'

    filter!(x -> x[i] == oxmc, i1)
    filter!(x -> x[i] == comc, i2)

    length(i1) == 1 && ox == "" ? (ox = i1[1]) : nothing
    length(i2) == 1 && co == "" ? (co = i2[1]) : nothing
    ox != "" && co != "" ? break : continue
  end
  parse(Int, ox; base=2) * parse(Int, co; base=2)
end

@aoc(2021, 3)

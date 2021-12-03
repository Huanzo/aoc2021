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
  o₂ = ""
  co₂ = ""
  for i in 1:length(input[1])
    o₂bits = map(x -> parse(Int, x[i]), i1)
    co₂bits = map(x -> parse(Int, x[i]), i2)
    
    o₂mc = sum(o₂bits) >= length(o₂bits) / 2 ? '1' : '0'
    co₂mc = sum(co₂bits) >= length(co₂bits) / 2 ? '0' : '1'

    filter!(x -> x[i] == o₂mc, i1)
    filter!(x -> x[i] == co₂mc, i2)

    length(i1) == 1 && o₂ == "" ? (o₂ = i1[1]) : nothing
    length(i2) == 1 && co₂ == "" ? (co₂ = i2[1]) : nothing
    o₂ != "" && co₂ != "" ? break : continue
  end
  parse(Int, o₂; base=2) * parse(Int, co₂; base=2)
end

@aoc(2021, 3)

include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc


function p1(input::Vector{String})
  o = [[],[],[],[],[],[],[],[],[],[],[],[]]
  for l in input
    c = match(r"(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)", l).captures
    for i in 1:12
      push!(o[i], c[i])
    end
  end
  γ = ""
  ϵ = ""
  for n in o
    γ *= count(==("1"), n) > count(==("0"), n) ? "1" : "0"
    ϵ *= count(==("1"), n) > count(==("0"), n) ? "0" : "1"
  end
  parse(Int, γ; base=2) * parse(Int, ϵ; base=2)
end


function p2(input::Vector{String})
  i1 = deepcopy(input)
  i2 = deepcopy(input)
  ox = ""
  co = ""
  for i in 1:length(input[1])
    oxbits = map(x -> x[i], i1)
    oxmc = count(==('1'), oxbits) >= count(==('0'), oxbits) ? '1' : '0'
    filter!(x -> x[i] == oxmc, i1)

    cobits = map(x -> x[i], i2)
    comc = count(==('1'), cobits) >= count(==('0'), cobits) ? '0' : '1'
    filter!(x -> x[i] == comc, i2)

    if length(i1) == 1 && ox == ""
      ox = i1[begin]
    end

    if length(i2) == 1 && co == ""
      co = i2[begin]
    end
  end
  parse(Int, ox; base=2) * parse(Int, co; base=2)
end

@aoc(2021, 3)

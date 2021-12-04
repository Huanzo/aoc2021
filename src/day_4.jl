include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Pipe: @pipe

function read_boards(input)
  in = filter(!=(""), input)
  boards = []
  for i in 1:5:length(in)
    board = []
    for x in 0:4
      row = @pipe split(in[i+x], " ") |> filter(!=(""), _) |> parse.(Int, _)
      push!(board, row)
    end
    push!(boards, vcat(board...))
  end

  return boards
end

function mark_board(board, n)
  idx = findall(==(n), board)
  for i in idx
    board[i] = -1
  end
end

function is_winner(board)
  for i in 1:5:length(board)
    if unique(board[i:i+4]) == [-1]
      return true
    end
  end

  for x in 1:5
    if unique(board[x:5:length(board)]) == [-1]
      return true
    end
  end
  return false
end

function score(board, n)
  sum(filter(!=(-1), board)) * n
end

function scores(numbers, boards)
  scores = []
  winners = []
  for n in numbers
    for (i, board) in enumerate(boards)
      i in winners ? continue : mark_board(board, n)
      if is_winner(board)
        push!(winners, i)
        push!(scores, score(board, n))
      end
    end
  end
  return scores
end

function p1(input::Vector{String})
  numbers = @pipe split(input[1], ",") |> parse.(Int, _)

  boards = read_boards(input[3:end])
  return scores(numbers, boards)[1]
end


function p2(input::Vector{String})
  numbers = @pipe split(input[1], ",") |> parse.(Int, _)

  boards = read_boards(input[3:end])
  return scores(numbers, boards)[end]
end

@aoc(2021, 4)

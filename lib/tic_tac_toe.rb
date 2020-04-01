WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
   puts " #{board[0] } | #{board[1] } | #{board[2] } "
   puts "-----------"
   puts " #{board[3] } | #{board[4] } | #{board[5] } "
   puts "-----------"
   puts " #{board[6] } | #{board[7] } | #{board[8] } "
 end

 def input_to_index(user_input)
  user_input.to_i-1
end

def move(board, position, token)
  index = position.to_i - 1
  board[position] = token
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
#  index = position.to_i-1
 (index).between?(0,8) && !(position_taken?(board, index))
end

def turn(board)
  puts "Please enter 1-9:"
   input = gets.strip
   index = input_to_index(input)
   if valid_move?(board, index)
      move(board, index)
      display_board(board)
    else
      turn(board)
   end
  move(board, index)
end

#def turn(board)
#  puts "Please enter 1-9:"
#  user_input = gets.strip #receiving user's input
#  index = input_to_index(user_input)
#   if valid_move?(board, index)
      ##token = current_player(board)
      ##move(board, position, token)
      player_move(board, index, current_player(board))
      display_board(board)
#    else
      turn(board)
#   end
#  move(board, position, token)
#end

def turn_count(board)
  # board.count{|token| token == "X" || token == "O"}
  # 9 - board.count(" ")
  turns = 0
  board.each do |token|
    if token == "X" || token == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
 WIN_COMBINATIONS.detect do |combo|
   board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board) #return true if every element in the board contains either an "X" or an "O"
  board.all? { |index| index == "X" || index == "O" }
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif !won?(board) && !full?(board)
    return false
  else won?(board)
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    current_player(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat\'s Game!"
  end
end

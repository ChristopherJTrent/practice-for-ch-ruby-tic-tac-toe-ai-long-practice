require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    # debugger
    node = TicTacToeNode.new(game.board, mark)
    children = node.children
    winner_children = children.filter {|child| child.winning_node?(mark)}
    winner_children += children.reject {|child| child.losing_node?(mark)}
    winner = winner_children.first
    raise "unwinnable game" if winner == nil
    winner.prev_move_pos
  end
end

if $PROGRAM_NAME == __FILE__
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
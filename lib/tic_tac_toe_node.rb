require_relative 'tic_tac_toe'

require 'byebug'

class TicTacToeNode
    attr_reader :board, :next_mover_mark, :prev_move_pos
    def initialize(board, next_mover_mark, prev_move_pos = nil)
        @board = board
        @next_mover_mark = next_mover_mark
        @prev_move_pos = prev_move_pos
    end

    def losing_node?(evaluator)
        if board.over?
            return true if board.winner != evaluator
            return false
        end
        return false if children.all? {|child| child.board.tied?}
        return true if next_mover_mark == evaluator && children.all?{|child| child.losing_node?(evaluator)}
        return true if next_mover_mark != evaluator && children.any?{|child| child.losing_node?(evaluator)}
        false
    end

    def winning_node?(evaluator)
        if board.over?
            return true if board.winner == evaluator
            return false
        end
        return true if next_mover_mark == evaluator && children.any?{|child| child.winning_node?(evaluator)}
        return true if next_mover_mark != evaluator && children.all?{|child| child.winning_node?(evaluator)}
        false
    end

    # This method generates an array of all moves that can be made after       
    # the current move.
    def children
        next_moves = []
        board.rows.each.with_index do |row, i|
            row.each.with_index do |col, j|
                # Deep copy of @board
                # new_board = Board.new(@board.rows.dup.map {|ele| ele.dup})
                # Switch mark
                next unless board.empty?([i,j])
                new_board = board.dup
                mover_mark = next_mover_mark == :x ? :o : :x
                #next next_moves << TicTacToeNode.new(new_board, mover_mark) if new_board[[i, j]]
                new_board[[i, j]] = next_mover_mark
                move_pos = [i, j]
                next_moves << TicTacToeNode.new(new_board, mover_mark, move_pos)
            end
        end
        next_moves
    end
end
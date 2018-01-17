require_relative 'nullpiece.rb'
require 'byebug'

class Piece

  attr_accessor :pos, :team

  def initialize(pos, board, team)
    @pos = pos
    @board = board
    @team = team
  end

  def team_piece?(pos)
    self.team == @board[pos].team
  end

  def null_piece_check?(pos)
    @board[pos].is_a?(NullPiece)
  end

end

module SlidingPieces

  def vertical_move
    [[1,0], [-1,0]]
  end

  def horizontal_move
    [[0,1], [0,-1]]
  end

  def diagonal_move
    [[1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def sliding_moves(pos)
    possible_moves = []
    possible_directions.each do |dir|
      temp = pos
      while @board.in_bounds?(temp)
        temp[0] += dir[0]
        temp[1] += dir[1]

        if null_piece_check?(temp)
          possible_moves << temp
        elsif !team_piece?(temp)
          possible_moves << temp
          break
        elsif team_piece?(temp)
          break
        end
      end

      temp = pos
    end
    possible_moves
  end
end

module Stepping_Pieces
  def step_moves
    possible_moves = []
    possible_directions.each do |dir|
      temp = pos
      if @board.in_bounds?(temp)
        temp[0] += dir[0]
        temp[1] += dir[1]

        if null_piece_check?
          possible_moves << temp
        elsif !team_piece?(temp)
          possible_moves << temp
          break
        elsif team_piece?(temp)
          break
        end
      end

      temp = pos
    end
    possible_moves
  end


end
# class Queen < Piece
#   include SlidingPieces
#   def move_dirs
#
#   end
# end

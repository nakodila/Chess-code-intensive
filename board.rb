require_relative 'piece.rb'
require_relative 'display.rb'
require_relative 'nullpiece.rb'
require_relative 'queen.rb'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    place_pieces
  end

  def place_pieces
    (0..1).each do |i|
      (0..7).each do |j|
        self[[i, j]] = Piece.new([i, j], self, 1)
      end
    end

    (6..7).each do |i|
      (0..7).each do |j|
        self[[i, j]] = Piece.new([i, j], self, 2)
      end
    end

    (2..5).each do |i|
      (0..7).each do |j|
        self[[i,j]] = NullPiece.instance
      end
    end
    self[[1,5]] = Queen.new()
  end

  def [](pos)
    row,col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row,col = pos
    @grid[row][col] = piece
  end

  def move_piece(start_pos, end_pos)
    if empty_pos?(start_pos)
      raise NoPieceError
    end

    unless empty_pos?(end_pos)
      raise AlreadyTakenError
    end

    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
  end

  def empty_pos?(pos)
    self[pos].nil?
  end

  def in_bounds?(pos)
    valid = (0..7).to_a
    valid.include?(pos[0]) && valid.include?(pos[1])
  end
end

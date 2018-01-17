class Queen < Piece
  include SlidingPieces

  def initialize
    super
  end

  def possible_directions
    vertical_move + horizontal_move + diagonal_move
  end


end

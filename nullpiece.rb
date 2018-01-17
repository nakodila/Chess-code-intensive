require 'singleton'
require_relative 'piece.rb'
class NullPiece < Piece
  include Singleton

  attr_reader :symbol

  def initialize
    @symbol
  end

end

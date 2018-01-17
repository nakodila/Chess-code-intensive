require 'colorize'

require_relative 'cursor.rb'

class Display

  attr_reader :cursor

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
    @selected = false
  end

  def move_cursor
    @selected = @cursor.selected
    @cursor.get_input
  end

  def render(board)
    num = 0
    while num < 20

      system("clear")
      puts "cursor_pos: #{@cursor.cursor_pos}"
      puts "__________________________"
      board.grid.each_with_index do |row, i|
        row.each_with_index do |sq, j|
          if @cursor.cursor_pos == [i,j] && @selected == true
            print "|" + "  ".colorize(:background => :light_blue)
          elsif @cursor.cursor_pos == [i,j] && @selected == false
            print "|" + "  ".colorize(:background => :yellow)
          else
            print "|  "
          end
        end
        puts "|\n__________________________"
      end
      move_cursor

      num += 1
    end
  end
end

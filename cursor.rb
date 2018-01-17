
require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}
class OutOfBoundsError < StandardError; end

class Cursor

  attr_reader :cursor_pos, :board, :selected

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
  end

  def get_input
    begin
      key = KEYMAP[read_char]
      handle_key(key)
    rescue OutOfBoundsError
      retry
    end
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    case key
    when :return, :space
      @selected = true
      @cursor_pos
    when :left
      @selected = false
      update_pos([0, -1])
    when :right
      @selected = false
      update_pos([0, 1])
    when :up
      @selected = false
      update_pos([-1, 0])
    when :down
      @selected = false
      update_pos([1, 0])
    when :ctrl_c
      Process.exit(0)
    end
  end
  # a) return the @cursor_pos (in case of :return or :space),
  # b) call #update_pos with the appropriate movement difference from MOVES and return nil (in case  of :left, :right, :up, and :down), or
  # c) exit from the terminal process (in case of :ctrl_c).


  def update_pos(diff)
    temp = @cursor_pos
    temp[0] +=  diff[0]
    temp[1] += diff[1]
    if @board.in_bounds?(temp)
      @cursor_pos = temp
    else
      raise OutOfBoundsError
    end

    @cursor_pos
  end


end

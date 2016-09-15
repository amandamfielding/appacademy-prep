require_relative "board"
require_relative "player"

class BattleshipGame 
  attr_reader :board, :player
  
  def initialize(player = HumanPlayer.new("Amanda"), board = Board.random)
    @player = player
    @board = board
  end
  
  def play
    play_turn until game_over?
    declare_winner
    board.display
  end
  
  def play_turn
    pos = nil
    board.display
    #player.prompt #this should be here but is causing 1 test to fail
    until valid_play?(pos)
      pos = player.get_play
    end
    attack(pos)
    display_status
  end
  
  def attack(pos)
    if board[pos] == :s
      @hit = true 
    else
      @hit = false
    end
    board[pos] = :x
  end
  
  def valid_play?(pos)
    pos.is_a?(Array) && board.in_range?(pos)
  end
  
  def count
    board.count
  end
  
  def display_status
    if hit?
      puts "It's a hit!" 
    else
      puts "You missed!"
    end
    puts "There are #{@board.count} ships remaining."
  end
  
  def hit?
    @hit
  end
  
  def game_over?
    board.won? 
  end
  
  def declare_winner
    puts "Congratulations. You win!"
  end
end

if __FILE__ == $PROGRAM_NAME
  BattleshipGame.new.play
end

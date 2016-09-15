class Hangman
  MAX_GUESSES = 8
  attr_reader :guesser, :referee, :board
  
  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @num_remaining_guesses = MAX_GUESSES
  end
  
  def play
    setup
    while @num_remaining_guesses > 0
      p @board
      take_turn
      if won?
        p @board
        puts "Guesser wins!"
        return
      end
    end
    puts "The word was #{@referee.require_secret}."
    puts "Guesser loses."
  end
  
  def setup
    @secret_length = @referee.pick_secret_word
    @guesser.register_secret_length(@secret_length)
    @board = [nil] * @secret_length
  end
  
  def take_turn
    guess = @guesser.guess(@board)
    indicies = @referee.check_guess(guess)
    update_board(guess,indicies)
    @num_remaining_guesses -= 1 if indicies.empty?
    @guesser.handle_response(guess,indicies)
  end
  
  def update_board(guess,indicies)
    indicies.each {|i| @board[i] = guess}
  end
  
  def won?
    @board.all?
  end
end

class HumanPlayer
  
  ##METHODS IF HUMAN IS GUESSER
  def register_secret_length(length)
    puts "The secret word is #{length} letters long."
  end
  
  def guess(board)
    p @board
    puts "Input guess: "
    gets.chomp
  end
  
  def handle_response(guess,response)
    "Found #{guess} at positions #{response}"
  end
  
  ##METHODS IF HUMAN IS REFEREE
  def pick_secret_word
    puts "How long is your secret word?"
    @secret_length = gets.chomp.to_i
  end
  
  def check_guess(guess)
    puts "Player guessed #{guess}"
    puts "What positions does this letter occur at?"
    gets.chomp.split(",").map(&:to_i)
  end
  
  def require_secret
    puts "The player is out of guesses. What was the secret word?"
    gets.chomp
  end
end

class ComputerPlayer
  def self.player_with_dict_file(dict_file_name)
    ComputerPlayer.new(File.readlines(dict_file_name).map(&:chomp))
  end
  
  attr_reader :candidate_words
  
  def initialize(dictionary)
    @dictionary = dictionary
  end
  
  ##METHODS IF COMPUTER IS GUESSER
  def register_secret_length(length)
    @candidate_words = @dictionary.select {|word| word.length == length}
  end
  
  def guess(board)
    letter_freq = Hash.new(0)
    @candidate_words.each do |word|
      word.each_char do |char|
        letter_freq[char] += 1
      end
    end
    letter_freq.delete_if {|k,v| board.include?(k)}
    letter_freq.max_by {|k,v| v}.first
  end
  
  def handle_response(guess,response)
    @candidate_words.reject! do |word|
      delete = false
      word.split("").each_with_index do |letter,idx|
        if letter == guess && !response.include?(idx)
          delete = true
          break
        elsif letter != guess && response.include?(idx)
          delete = true
          break
        end
      end
      delete
    end
    @candidate_words
  end
 
  
  ##METHODS IF COMPUTER IS REFEREE
  def pick_secret_word
    #chooses random word from dictionary.txt and returns length
    @secret_word = @dictionary.sample
    @secret_word.length
  end
  
  def check_guess(letter)
    correct_inidices = []
    @secret_word.split("").each_with_index do |char,idx|
      correct_inidices << idx if char == letter
    end
    correct_inidices
  end
  
  def require_secret
    @secret_word
  end
end

if __FILE__ == $PROGRAM_NAME
  print "Guesser: Computer (yes/no)? "
  if gets.chomp == "yes"
    guesser = ComputerPlayer.player_with_dict_file("dictionary.txt")
  else
    guesser = HumanPlayer.new
  end 
  
    print "Referee: Computer (yes/no)? "
  if gets.chomp == "yes"
    referee = ComputerPlayer.player_with_dict_file("dictionary.txt")
  else
    referee = HumanPlayer.new
  end

  Hangman.new({guesser: guesser, referee: referee}).play
end

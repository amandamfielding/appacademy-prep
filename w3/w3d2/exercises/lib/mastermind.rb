class Code
  PEGS = {
      "R" => "red",
      "G" => "green",
      "B" => "blue",
      "Y" => "yellow",
      "O" => "orange",
      "P" => "purple" 
    }
  attr_reader :pegs
    
  def self.parse(str)
    pegs = str.split("").map do |letter|
      raise error unless PEGS.has_key?(letter.upcase)
      PEGS[letter.upcase]
    end
    Code.new(pegs)
  end
  
  def self.random
    pegs = []
    4.times { pegs << PEGS.values.sample}
    Code.new(pegs)
  end
  
  def initialize(pegs)
    @pegs = pegs
  end
  
  def [](i)
    pegs[i]
  end
  
  def exact_matches(other_code)
    exact_matches = 0
    pegs.each_index do |i|
      exact_matches += 1 if self[i] == other_code[i]
    end
    exact_matches
  end
  
  def near_matches(other_code)
    other_color_counts = other_code.color_counts
    near_matches = 0
    self.color_counts.each do |color, count|
      next unless other_color_counts.has_key?(color)
      near_matches += [count, other_color_counts[color]].min
    end
    near_matches - self.exact_matches(other_code)
  end
  
  def ==(other_code)
    return false unless other_code.is_a?(Code)
    self.pegs == other_code.pegs
  end

  protected ##what does this do?

  def color_counts
    color_counts = Hash.new(0)
    @pegs.each do |color|
      color_counts[color] += 1
    end
    color_counts
  end
end

class Game
  attr_reader :secret_code
  def initialize(secret_code = Code.random)
    @secret_code = secret_code
  end
  
  def play
    puts "There are 6 letters: R,G,B,Y,O,P. 4 of them make up the secret code, for example, 'RGBY'. There can be duplicates. Take a guess!"
    lost = true
    10.times do
      guess = get_guess
      if guess == @secret_code
        puts "You got it! The secret code was #{@secret_code}."
        lost = false
        break
      else 
        display_matches(guess)
      end
    end
    puts "You lose. The secret code was #{@secret_code}" if lost == true
  end
  
  def get_guess
    puts "Guess the code:"

    begin ## what is this??
      Code.parse(gets.chomp)
    rescue
      puts "Error parsing code!"
      retry
    end
  end
  
  def display_matches(guess)
    exact_matches = @secret_code.exact_matches(guess)
    near_matches = @secret_code.near_matches(guess)

    puts "You got #{exact_matches} exact matches!"
    puts "You got #{near_matches} near matches!"
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
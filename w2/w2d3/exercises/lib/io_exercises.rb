# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  answer = rand(1..100)
  counter = 0
  while true
    puts "Guess a number between 1 and 100"
    guess = gets.chomp
    counter += 1
    if !(0..100).to_a.include?(guess.to_i)
      puts "Invalid guess, try again." 
    elsif guess.to_i > answer
      puts "Your guess was #{guess}. This is too high. Try again."
    elsif guess.to_i < answer
      puts "Your guess was #{guess}. This is too low. Try again."
    elsif guess.to_i == answer
      puts "Correct, the secret number was #{answer}. It only took you #{counter} tries."
      break
    end
  end
end

def shuffle_file(filename)
  base = File.basename(filename, ".*")
  extension = File.extname(filename)
  File.open("#{base}-shuffled#{extension}", "w") do |f|
    File.readlines(filename).shuffle.each do |line|
      f.puts line.chomp
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.length == 1
    shuffle_file(ARGV.shift)
  else
    puts "ENTER FILENAME TO SHUFFLE:"
    filename = gets.chomp
    shuffle_file(filename)
  end
end

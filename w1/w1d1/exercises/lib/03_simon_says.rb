def echo(input)
  input
end

def shout(input)
  input.upcase
end

def repeat (input, number_of_times=2)
  ("#{input} " * number_of_times).split.join(" ")
end

def start_of_word(input,number_of_char=1)
  input[0,number_of_char]
end

def first_word(input)
  input.split.first
end

def titleize(input)
  small_words = ["the","a","and","or","over"]
  words = input.split
  words.map! do |word|
    if !small_words.include?(word) || words.first == word
      word[0].upcase + word[1..-1] 
    else
      word
    end
  end
  words.join(" ")
end
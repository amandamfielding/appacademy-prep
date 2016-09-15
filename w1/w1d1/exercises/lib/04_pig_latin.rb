def translate(sentence)
  sentence.split.map {|word| translate_word(word)}.join(" ")
end

def translate_word(word)
  vowels = "aeiou".chars
  if vowels.include?(word[0].downcase)
    "#{word}ay" 
  else
    phoneme_end = 0
    until vowels.include?(word[phoneme_end])
      phoneme_end += 1
    end
    phoneme_end +=1 if word[phoneme_end-1] == "q"
    "#{word[phoneme_end..-1]}#{word[0...phoneme_end]}ay"
  end
end
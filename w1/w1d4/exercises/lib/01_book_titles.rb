class Book
  SMALL_WORDS = ["the","a","an","and","in","of"]
  attr_reader :title
  def title=(title)
    words = title.split
    new_words = words.map.with_index do |word,idx| 
      if !SMALL_WORDS.include?(word) || idx == 0
        word = "#{word[0].upcase}#{word[1..-1]}" 
      else
        word = word
      end
    end
    @title = new_words.join(" ")
  end
end

class Dictionary
  attr_reader :entries
  def initialize
    @entries = {}
  end
  def add(new_entries)
    if new_entries.is_a?(String)
      @entries[new_entries] = nil
    elsif new_entries.is_a?(Hash)
      @entries.merge!(new_entries)
    end
  end
  def keywords
    @entries.keys.sort
  end
  def include?(word)
    @entries.has_key?(word)
  end
  def find(fragment)
    @entries.select do |word,definition|
      word.match(fragment)
    end
  end
  def printable
    entries = keywords.map do |keyword|
      "[#{keyword}] \"#{@entries[keyword]}\""
    end
    entries.join("\n")
  end
end
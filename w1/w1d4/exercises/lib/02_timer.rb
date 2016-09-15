class Timer
  attr_accessor :seconds
  def initialize(seconds = 0)
    @seconds = seconds
  end
  
  def hours
    Integer(@seconds/3600)
  end
  
  def minutes
    Integer((@seconds % 3600) / 60)
  end
  
  def minute_seconds
    Integer(@seconds % 60)
  end
  
  def padded(num)
    num < 10 ? "0#{num}" : "#{num}"
  end
  
  def time_string
    "#{padded(hours)}:#{padded(minutes)}:#{padded(minute_seconds)}"
  end
end

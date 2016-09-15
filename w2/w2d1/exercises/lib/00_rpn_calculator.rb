class RPNCalculator
  def initialize
    @stack = []
  end
  
  def push(number)
    @stack << number
  end
  
  def plus
    perform(:+)
  end
  
  def minus
    perform(:-)
  end
  
  def times
    perform(:*)
  end
  
  def divide
    perform(:/)
  end
  
  def perform(symbol)
    raise "calculator is empty" unless @stack.length >= 2
    right_num = @stack.pop
    left_num = @stack.pop
    case symbol
    when :+
      @stack << left_num + right_num
    when :-
      @stack << left_num - right_num
    when :*
      @stack << left_num * right_num
    when :/
      @stack << left_num.to_f / right_num
    else
      raise "unsupported symbol: " 
    end
  end
  
  def value
    @stack[-1]
  end
  
  def tokens(string)
    operators = ["+","-","*","/"]
    string.split.map {|char| operators.include?(char) ? char.to_sym : Integer(char) }
  end
  
  def evaluate(string)
    tokens(string).each do |token|
      case token
      when Integer
        push(token)
      when Symbol
        perform(token)
      end
    end
    value
  end
end


def add(num1,num2)
  num1 + num2
end

def subtract(num1,num2)
  num1 - num2
end

def sum(numbers)
  return 0 if numbers == []
  numbers.inject(:+)
end

def multiply(*numbers)
  numbers.inject(:*)
end

def power(num1,num2)
  num1**num2
end

def factorial(number)
  return 1 if number == 0
  (1..number).inject(:*)
end

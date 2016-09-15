def reverser(&prc)
  yield.split(" ").map {|word| word.reverse}.join(" ")
end

def adder(surplus = 1, &prc)
  yield + surplus
end

def repeater(times = 1, &prc)
  times.times {yield}
end

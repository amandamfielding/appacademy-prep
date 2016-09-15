def measure(times = 1, &prc)
  start_time = Time.now
  times.times { yield }
  (Time.now - start_time) / times
end

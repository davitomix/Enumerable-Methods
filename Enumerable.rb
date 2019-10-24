module Enumerable
  def my_each
    return to_enum unless block_given?
    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end
end

arr = [1, 2, 3, 4, 5, 6]
arr.my_each do |num|
  puts num * num # prints out element squared
end

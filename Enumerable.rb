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

  def my_each_with_index
    return to_enum unless block_given?
    (0..size).each do |x|
      yield self[x], x
    end
  end

  def my_select
    return to_enum unless block_given?
    selected_items = []
    my_each {|i| selected_items << i if yield(i)}
    selected_items
  end

  def my_all?(param = nil)
    if block_given?
      my_each { |i| return false unless yield(i)}
    elsif param.is_a? Class
      my_each { |i| return false unless i.is_a? param}
    elsif param.is_a? Regexp
      my_each { |i| return false unless param =~ i }
    elsif param.nil?
      my_each { |i| return false unless i}
    else
      my_each {|i| return false unless i == param }
    end
  true
  end

  def my_any?(param = nil)
    if block_given?
      my_each { |i| return true unless yield(i)}
    elsif param.is_a? Class
      my_each { |i| return true unless i.is_a? param}
    elsif param.is_a? Regexp
      my_each { |i| return true unless param =~ i }
    elsif param.nil?
      my_each { |i| return true unless i}
    else
      my_each {|i| return true unless i == param }
    end
  false
  end

  def my_none?
    if block_given?
      my_each {|i| return true if !yield(i)}
    elsif param.is_a? Regexp
      my_each { |i| return true if !param =~ i }
    elsif param.is_a? Class
      my_each { |i| return true if !i.is_a? param}
    elsif param.nil?
      my_each { |i| return true if !i}
    else
      false
    end
    false
  end

  def my_count(value)
    counter = 0
    if block_given?
      my_each {|i| counter += 1 if self[i] == i}
    elsif value.is_a? Enumerator
      my_each {|i| counter += 1 if self[i] == i}
    else
      self.size
    end
  end

  def my_map
    new_array = []
    if block_given?
      my_each {|i| new_array.push(yield(i))}
    else
      to_enum
    end
  end

  def my_inject(*args)
    arr = to_a.dup
    if args[0].nil?
      operation = arr.shift
    elsif args[1].nil? && !block_given?
      symbol = args[0]
      operation = arr.shift
    elsif args[1].nil? && block_given?
      operation = args[0]
    else
      operation = args[0]
      symbol = args[1]
    end
    arr[0..size].my_each do |elem|
      operation = if symbol 
                    operation.send(symbol, elem)
                  else 
                    yield(operation, elem)
                  end
    end
    operation
  end
end

puts '---------------------------------------------'
puts 'my_each'
puts (1..10).each_cons(3) { |a| p a }
=begin
# outputs below
[1, 2, 3]
[2, 3, 4]
[3, 4, 5]
[4, 5, 6]
[5, 6, 7]
[6, 7, 8]
[7, 8, 9]
[8, 9, 10]
=end
p [1, 2, 3, 4, 5, 6].my_each #=> Enumerator


puts '---------------------------------------------'
puts 'my_each_with_index'
hash = Hash.new
%w(cat dog wombat).each_with_index { |item, index|
  hash[item] = index
}
puts hash   #=> {"cat"=>0, "dog"=>1, "wombat"=>2}
p [1, 2, 3, 4, 5, 6].my_each_with_index #=> Enumerator

puts '---------------------------------------------'
puts 'my_select'
p (1..10).find_all { |i|  i % 3 == 0 }   #=> [3, 6, 9]
p [1,2,3,4,5].select { |num|  num.even?  }   #=> [2, 4]
p [:foo, :bar].filter { |x| x == :foo }   #=> [:foo]
arr = [12.2, 13.4, 15.5, 16.9, 10.2]
new_arr = arr.my_select do |num|
  num.to_f > 13.3 
end
p new_arr                #=> [13.4, 15.5, 16.9]
p [12.2, 13.4, 15.5, 16.9, 10.2].my_select #=> Enumerator

puts '---------------------------------------------'
puts 'my_all?'
puts %w[ant bear cat].all? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].all? { |word| word.length >= 4 } #=> false
puts %w[ant bear cat].all?(/t/)                        #=> false
puts [1, 2i, 3.14].all?(Numeric)                       #=> true
puts [nil, true, 99].all?         #=> false
puts [].all?                      #=> true

puts '---------------------------------------------'
puts 'my_any?'
puts %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].any? { |word| word.length >= 4 } #=> true
puts %w[ant bear cat].any?(/d/)       #=> false
puts [nil, true, 99].any?(Integer)    #=> true
puts [nil, true, 99].any?             #=> true
puts [].any?                          #=> false

puts '---------------------------------------------'
puts 'my_none?'
puts %w{ant bear cat}.none? { |word| word.length == 5 } #=> true
puts %w{ant bear cat}.none? { |word| word.length >= 4 } #=> false
puts %w{ant bear cat}.none?(/d/)                        #=> true
puts [1, 3.14, 42].none?(Float)                         #=> false
puts [].none?                                           #=> true
puts [nil].none?                                        #=> true
puts [nil, false].none?                                 #=> true
puts [nil, false, true].none?                           #=> false

puts '---------------------------------------------'
puts 'my_count'
ary = [1, 2, 4, 2]
puts ary.count               #=> 4
puts ary.count(2)            #=> 2
puts ary.count{ |x| x%2==0 } #=> 3

puts '---------------------------------------------'
puts 'my_map'
p (1..4).map { |i| i*i }      #=> [1, 4, 9, 16]
p (1..4).map                  #=> Enumerator

puts '---------------------------------------------'
puts 'my_inject'
arr = [5, 6, 7, 8, 9, 10]
puts arr.my_inject :*
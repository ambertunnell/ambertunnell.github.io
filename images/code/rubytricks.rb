#each.with_index 

array = [1,2,3,4]

new_array = Array.new 
array.each.with_index {|num, index| new_array << num * index }
new_array #=> [0,2,6,12]

#collect.with_index 

new_array = array.collect.with_index {|num, index| num * index}
new_array #=> [0,2,6,12]


#freeze

array = [1,2,3]
array.freeze
array.collect! {|num| num * 27}
  #=> "RuntimeError: can't modify frozen Array"
array.frozen? 
  #=> true  
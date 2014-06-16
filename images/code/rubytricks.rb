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

#Convert a number to a different base
2.to_s(2) #=> "10"

5678437.to_s(2) #=> "10101101010010101100101"
5678437.to_s(23) #=> "k6g6d"

#Convert array to hash
animals = ["cat","meow","snake","hiss"]
Hash[*animals] #=> {"cat"=>"meow", "snake"=>"hiss"} 

#Using splat in arguments

#Takes an optional number of arguments
def splat_is_awesome(*a)
  a
end
splat_is_awesome("and","it","looks","cool","too")  
 # => ["and", "it", "looks", "cool", "too"] 

def splat_power(*a,b)
  a,b
end
splat_power("powerful","stuff","here")

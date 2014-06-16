---
layout: post
title: "Hidden Ruby magic tricks"
date: 2014-06-15 17:53:07 -0400
comments: true
categories: [Flatiron School, Ruby, methods_magic]
---

I've been learning Ruby for about 2-3 months now, and I've already fallen in love. Hard. The language is so intuitive that often I find myself trying methods in Ruby that I've never learned about just because I think there is a good chance they'll work. And, often if they don't do exactly what I thought they did, they still do something interesting that is awesome.

In this post, I plan to discuss hidden Ruby tricks that many beginning Rubyists might not know about (yet!) that I've discovered online or through playing around with Ruby. This is by no means a comprehensive list, but I hope it illustrates a few of Ruby's awesome tricks. They are all included in the <a href="http://ruby-doc.org/">Ruby Documentation</a> if you want to learn more. Also, shout out in the comments if you know of any other good ones to add to the list!

<h2>using .to_s(base) to convert integers to different base</h2>
I never would have imagined that this would work, but it's really cool. If you convert an integer to a string (using .to_s), it can take an argument that will convert it to a different base. It works up to base 36.

``` ruby .to_s(base)
#2 in binary
2.to_s(2) #=> "10"

#converting to binary
5678437.to_s(2) #=> "10101101010010101100101"

#converting to base 23
5678437.to_s(23) #=> "k6g6d"
```

<h2>.freeze</h2>
Freeze! Because this is Ruby, the method .freeze does exactly what you think it does. It freezes the object from being altered in any way. And you can even check if an object is frozen by asking it if it's frozen!

``` ruby .freeze 
array = [1,2,3]
array.freeze
array.collect! {|num| num * 27}
  #=> "RuntimeError: can't modify frozen Array"
array.frozen? 
  #=> true 
```  

<h2 style="font-size:30px">Splat!</h2>
Splat(*) is very cool and powerful it seems. Here's a few splat tricks I've learned. 

<h2>allows an array to take unspecified amount of arguments</h2>
It allows an array to take any number of arguments, and returns those values in a array. You can use it with other aguments, if you want to separate the first or last argument from the array.

``` ruby splat_power
#splat argument as the only arugment 
def splat_is_awesome(*a)
  a
end

splat_is_awesome("and","it","looks","cool","too")  
 #=> ["and", "it", "looks", "cool", "too"] 

#splat as last argument
def splat_power(a,*b)
  [a,b]
end

splat_power("powerful","stuff","here")
 #=> ["powerful", ["stuff", "here"]] 

#splat as first argument
def splat_power_reversed(*a,b)
  [a,b]
end

splat_power_reversed("powerful","stuff","here")
 #=> [["powerful", "stuff"], "here"] 
``` 

<h2>using splat to convert an array to a hash</h2>
I think this is the kind of thing that doesn't seem very useful until you get that one rare type of problem where it ends up being perfect for. If you use splat on an array as the key in a new Hash, it will automatically split the array into key-value pairs and then create the new hash. Note that it only works when you have an array with an even number of elements.


``` ruby array to hash using splat
animals = ["cat","meow","snake","hiss"]
Hash[*animals] #=> {"cat"=>"meow", "snake"=>"hiss"} 

#It first splits the elements into pairs and then creates the Hash: 
# ["cat","meow","snake","hiss"] ==> 
# ["cat"=>"meow","snake"=>"hiss"] ==> 
# {"cat"=>"meow", "snake"=>"hiss"}  
```

<h2>collect.with_index</h2>
This one may seem obvious to most, but it was a happy discovery for me last week when I was trying to solve a problem. I had been familiar with the method <b>.each_with_index</b> for a while, and every time I needed to use indexes while iterating, I used it. But, as most Rubyists do, I vastly prefer .collect over .each in most cases, and was frustrated that I couldn't use indexes with collect. I'm not sure why I thought it could only work with .each, but I did for a while. But then I tried it, and it worked! .collect.with_index is a real thing! So, the method ".with_index" can work on either .each or .collect. 

``` ruby each.with_index 
array = [1,2,3,4]

new_array = Array.new 
array.each.with_index {|num, index| new_array << num * index }
new_array #=> [0,2,6,12]
```

``` ruby collect.with_index 
array = [1,2,3,4]

new_array = array.collect.with_index {|num, index| num * index}
new_array #=> [0,2,6,12]
```


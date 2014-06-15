---
layout: post
title: "Hidden Ruby magic tricks"
date: 2014-06-15 17:53:07 -0400
comments: true
categories: [Flatiron School, Ruby, methods_magic]
---
I've been learning for about 2-3 months now, and I've already fallen in love. Hard. The language is so intuitive that often I find myself trying methods in Ruby that I've never learned about just because I know there is a good chance they'll work. And, often if they don't do exactly what I thought they did, they still do something interesting. Which is still awesome.

In this post, I plan to discuss hidden Ruby tricks that many beginning Rubyists might not know about (yet!) that I've discovered online or through playing around with Ruby. 

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
Freeze! Because this is Ruby, the method .freeze does exactly what you think it does. It freezes the object from being altered in any way.

``` ruby .freeze 
array = [1,2,3]
array.freeze
array.collect! {|num| num * 27}
  #=> "RuntimeError: can't modify frozen Array"
array.frozen? 
  #=> true 
```  

<h2>collect.with_index</h2>
This one may be obvious to most, but it was a happy discovery for me. I had been familiar with the method <b>.each_with_index</b> for a while, and everytime I needed to use indexes while iterating, I used it. But, as most Rubyists do, I vastly prefer .collect over .each, and was frustrated that I couldn't use indexes with collect. But I tried it, and it worked! .collect.with_index is a real thing! So, the method ".with_index" can work on either .each or .collect. 

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

Shout out in the comments if you know of any other good ones to add to the list!
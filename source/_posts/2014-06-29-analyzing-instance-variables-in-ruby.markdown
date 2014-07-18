---
layout: post
title: "Analyzing instance variables in Ruby"
date: 2014-06-29 21:26:29 -0400
comments: true
categories: [Ruby, instance variables, self] 
---
Instance variables in Ruby can be accessed in two ways. Directly with an @ symbol, `@variable`, or through a method call, `self.variable`. Many Rubyists think these are synonymous. However, they are not. 

By accessing the data through the method call, you are protecting the data from being accessed directly. Therefore, if the data changes unexpectedly, you will only have to adjust the one method. If you access the data directly throughout your code, you may have to change it many times so that your code doesn't break.

It is a fine distinction, but can become an incredibly important one the larger your program is.

<!-- more -->

Here's an example. Let's set up a basic class to get us started.

```ruby Cat class
class Cat
  
  def initialize(name, age) 
    @name = name
    @age = age
  end 

end  
```
This Cat class can be initialized with two variables: @name and @age.

Now, let's make our class more interesting.

```ruby Cat class
class Cat
  
  def initialize(name, age) 
    @name = name
    @age = age
  end 

  def age_in_human_years 
    if @age == 0
      @human_age = 0
    elsif @age == 1
      @human_age = 15  
    else 
      @human_age = 16 + @age * 4
    end  
  end 

end  
``` 
Now, we have a method that accesses the @age instance variable that is initialized upon instantiation. By using '@' instead of 'self', we are directly accessing that variable.

But, what if we wanted a variable that actually equals age + 2? We could add in that variable and use it throughout. Like so:

```ruby Cat class
class Cat
  
  def initialize(name, age) 
    @name = name
    @age = age
    @new_age = age + 2 #=> addition
  end 

  def age_in_human_years 
    if @new_age == 0 #=> change 1
      @human_age = 0
    elsif @new_age == 1 #=> change 2
      @human_age = 15  
    else 
      @human_age = 16 + @new_age * 4 #=> change 3 
    end  
  end 

end  
``` 
One could argue that we could've just initialized @age to be equal to age+2, but I think that would go against Ruby convention and confuse matters. Plus, we could then never access both `age` and `age+2`. `@age` would be stuck at age + 2.

Okay, we made those changes. That wasn't too hard. However, what if we referenced this variable in a thousand different places? It just wouldn't be feasible or desirable to have to comb through the code and change them all.

Here's where `self` comes in. Let's go back one step and reimplement the example with `self`.

```ruby Cat class
class Cat

  attr_reader :age
  
  def initialize(name, age) 
    @name = name
    @age = age
  end 

  def age_in_human_years 
    if self.age == 0
      @human_age = 0
    elsif self.age == 1
      @human_age = 15  
    else 
      @human_age = 16 + self.age * 4
    end  
  end 

end  
```

So, we changed the `@age` to `self.age` throughout. And, added in a `attr_reader`,  which is shorthand for this method:

```ruby attr_reader
  def age
    @age
  end
```

It merely creates a method that can access the instance variable. So, to clarify, when we reference @age we are accessing the variable data directly. But, when we use self.age (note: the 'self' is actually optional), we are accessing the variable indirectly through this reader method.

So, again, say we want to make that age adjustment and add 2 to the given age.  Instead of adjusting the code accordingly, we can just create our own reader method for that variable.

```ruby Cat class
class Cat
  
  def age 
    @age + 2
  end   
  
  def initialize(name, age) 
    @name = name
    @age = age 
  end 

  def age_in_human_years 
    if self.age == 0
      @human_age = 0
    elsif self.age == 1
      @human_age = 15  
    else 
      @human_age = 16 + self.age * 4
    end  
  end 

end  
```
The only thing we did this time for that change is delete the default `attr_reader` method and define a short method that changes the information received when one calls `.age`. Also, this way, we can preserve access to the original given age, by calling `@age`, and we can access @age+2, by calling `.age`.

The difference may seem insignificant. And, in small programs, it probably is. But, as programs grow larger, this may make a significant difference in how costly one change may be.If you are only directly accessing the data of an instance variable in one place, you only have to change it in one place. But, if you are directly accessing it hundreds of times, you may have to look at all of those pieces to verify that they won't break now that the value of a variable has changed.

So, the take-away: always hide data from yourself. It is the best defensive strategy to protect your code from unexpected changes.  

###Additional Resources:
<li>[Practical Object-Oriented Design in Ruby (POODR)](http://www.poodr.com/) by Sandi Metz</li>

---
layout: post
title: "Insertion Sort in Ruby"
date: 2014-08-20 23:01:26 -0400
comments: true
categories: [sorting algorithms, ruby, computer science]
---

Insertion sort is another simple sorting algorithm. It creates a new array and iterates up the current array, placing the current element into the correct place in the new sorted array.

<ol>
  <li>First, take the first element of the unsorted array out of the array and put it into an empty new array.</li> 
  <li>Take the next element out of the unsorted array and place it into the new array. If it is smaller than the first element in the new array, swap them. If not, leave it at the end.
  <li>Take the next element out of the array and put it at the end of the new array. If it is larger than the previous end element, leave it. If not, iterate through the array until you find its correct position and insert it there.
  <li>Continue this process until your original array is empty and you have a new completely sorted array.</li>
</ol>

<!-- more -->

-> ![insertion sort video](http://upload.wikimedia.org/wikipedia/commons/0/0f/Insertion-sort-example-300px.gif "Insertion Sort") <-

While more efficent than Bubble Sort, Insertion Sort still has the same average and worse case time complexity of O(n^2). Like Bubble Sort, it is very inefficient for large data sets, but rather efficient for small data sets or data sets already mostly sorted (the best case time complexity is O(n)). 

Implementation of Insertion Sort in Ruby.

```ruby insertion sort
class InsertionSort

  def initialize(array)
    @array = array
    @sorted_array = []
  end

  def sort
    j = 0
    while @array.length > 0
      @sorted_array << @array.shift
      if @sorted_array.length > 1 && @sorted_array[j-1] > @sorted_array[j]
        @sorted_array.each.with_index do |n, i|
          if @sorted_array[i] > @sorted_array[-1]
            @sorted_array[i], @sorted_array[-1] = @sorted_array[-1], @sorted_array[i]
          end
          if (@sorted_array[i] <  @sorted_array[-1]) && (@sorted_array[i+1] > @sorted_array[-1])
            @sorted_array.insert(i+1, @sorted_array[-1])
            @sorted_array.slice!(-1)
          end
        end 
      end 
      j+=1
    end
    @sorted_array
  end 
end

print InsertionSort.new([4,1,6,3,5,2]).sort #=> [1, 2, 3, 4, 5, 6]
```

*This is the second post of a series of posts on various sorting algorithms. See the first here: [Bubble Sort](http://ambertunnell.github.io/blog/2014/08/20/bubble-sort-in-ruby/)*

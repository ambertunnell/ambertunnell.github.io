---
layout: post
title: "Sorting Algorithms Series: Bubble Sort"
date: 2014-08-20 21:37:50 -0400
comments: true
categories: [sorting algorithms, computer science]
---

*When I was learning Ruby, we never discussed sorting algorithms. It's my understanding that most sorting algorithm problems can be solved quite easily using built-in methods in most languages. That being said, it is important to understand the different sorting techniques available in computer science. Along those lines, here's a series of blog posts on the most common sorting algorithms!*

We'll start with Bubble Sort.

**Bubble Sort** is a simple sorting algorithm. 

<ol>
  <li>You start by comparing the first two items in an array. If the first item is larger than the second, you swap the two items.</li> 
  <li>Then, you compare the second and third items. If the second is larger than the third, you swap them.</li>
  <li>Continue until you reach the end of the array.</li>
  <li>Then, you start from the beginning again and repeat the process until you have one full pass of the array in which you did not swap any items.</li>
  <li>You now have a sorted array!</li>
</ol>

<!-- more -->

The name 'bubble sort' derives from the event of the smaller numbers slowly 'bubbling' to the front of the array through the swapping process. 

-> ![bubble sort video](http://upload.wikimedia.org/wikipedia/commons/c/c8/Bubble-sort-example-300px.gif "Bubble Sort") <-

Here's the bubble sort algorithm implemented in Ruby.

```ruby Bubble Sort in Ruby
class BubbleSort

  def initialize(array)
    @array = array
  end

  def sort 
    loop do 
      i = 1
      swap_number = 0
       while i < @array.length 
         if @array[i-1] > @array[i]
          @array[i-1], @array[i] = @array[i], @array[i-1] 
          swap_number += 1
         end
         i+=1
       end
      break if swap_number == 0
    end 
    return @array
  end 

end

print BubbleSort.new([4,1,2,6,3,5]).sort #=> [1, 2, 3, 4, 5, 6]
```

And, here's it in JavaScript.

```java Bubble Sort in JavaScript

function bubbleSort(array) {
    var swapNum;

    while (swapNum !== 0) {
        swapNum = 0;
        for (var i = 0; i < array.length; i++) {
            if (array[i] > array[i + 1]) {

                var first = array[i]; 
                var second = array[i+1]; 

                array[i] = second; 
                array[i+1] = first;

                swapNum++;
            }
        }
       
    }  
    return array;
}

bubbleSort([4,1,2,6,3,5]); //=> [1, 2, 3, 4, 5, 6]
```

One of the biggest problems with using bubble sort is that it isn't practical on large data sets. It is incredibly inefficient with an average and worst-case time complexity of О(n^2). 

In the best-case where the array is already sorted, the time complexity is O(n) because it only has to do one pass of the array, whereas most other algorithms still have to go through all their steps even when given an already-sorted array.

That being said, bubble sort is still a very undesirable and inefficient sorting technique.


*This is the first post in a series of posts on various sorting algorithms in computer science. See the entire series <a href="/blog/categories/sorting-algorithms/">here</a>.*
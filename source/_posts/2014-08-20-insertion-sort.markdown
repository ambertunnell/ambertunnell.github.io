---
layout: post
title: "Sorting Algorithms Series: Insertion Sort"
date: 2014-08-23 16:01:26 -0400
comments: true
categories: [sorting algorithms, computer science]
---

Like <a href="/blog/2014/08/20/bubble-sort/">Bubble Sort</a>, <strong>Insertion Sort</strong> is a simple sorting algorithm. 

Insertion Sort works by iterating up the current array, placing the current element into the correct place in the new sorted array.

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

```ruby Insertion Sort in Ruby
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

And in JavaScript: 

```java Insertion Sort in JavaScript
function insertionSort(array) {
    var sortedArray = [];

    for (var i = 0; i < array.length; i++) {

        sortedArray.push(array[i]);
        var len = sortedArray.length;

        if ((len > 1) && (sortedArray[len - 1] < sortedArray[len - 2])) {
            for (var j = 0; j < len; j++) {
                if ((len === 2) && (sortedArray[j] > sortedArray[len - 1])) 
                {
                    var first = sortedArray[j];
                    var second = sortedArray[len - 1];

                    sortedArray[j] = second;
                    sortedArray[len - 1] = first;
                } 
                else if ((sortedArray[j] <= sortedArray[len - 1]) 
                && (sortedArray[len - 1] <= sortedArray[j + 1])) 
                {
                    //Insert the new element where it belongs.
                    sortedArray.splice(j + 1, 0, sortedArray[len - 1]); 
                    // Delete it from the end of the array.
                    sortedArray.splice(sortedArray.length - 1, 1); 
                }
            }
        }
    }
    return sortedArray;

}

insertionSort([4, 1, 2, 6, 3, 5]); //=> [1, 2, 3, 4, 5, 6]
```

*This is the second post in a series of posts on various sorting algorithms in computer science. See the entire series <a href="/blog/categories/sorting-algorithms/">here</a>.*

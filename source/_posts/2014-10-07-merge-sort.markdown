---
layout: post
title: "Sorting Algorithms Series: Merge Sort"
date: 2014-10-07 14:54:35 -0400
comments: true
categories: [sorting algorithms, computer science, ruby]
published: true
---

<strong>Merge Sort</strong> is a divide and conquer sorting algorithm. It is much more efficent than either <a href="/blog/2014/08/20/bubble-sort/">Bubble Sort</a> or <a href="http://localhost:4000/blog/2014/08/23/insertion-sort/">Insertion Sort</a> with an average and worst case time complexity of  O(n log n).

In Merge Sort, you divide a list of items to be in the smallest units possible. You sort the smaller units, then repeatedly merge the small units back together until you have a sorted list.  

<ol>
  <li>Take an array of items. Split the array into single subunits.</li>
  <li>Since an item with only one input is considered sorted, merge the subunits together so that you now have subunits with 2 items each.</li>
  <li>Sort each of these 2-item subunits so that they are all ordered correctly.</li>
  <li>Continue merging the subunits together and sorting them individually until you have a completely merged and sorted list.</li>
</ol>

<!-- more -->

-> ![merge sort video](http://upload.wikimedia.org/wikipedia/commons/c/cc/Merge-sort-example-300px.gif "Merge Sort") <-

As discussed, Merge Sort has a very good time complexity. However, it does not have a good space complexity. Because it doesn't sort in place (like Bubble Sort), you need twice the space of the normal list in order to implement the sort. Despite this drawback, it is still worthwhile because of its efficiency. For example, Merge Sort's worst case time complexity O(n log n) is the same as Quicksort's <em>best case</em> time complexity.

```ruby Merge Sort in Ruby
class MergeSort
    def sort(array)
       
        if array.length <= 1
          return array 
        end

        middle = (array.length / 2.0).round
        length = array.length 
         
        first_array = array[0...middle]
        second_array = array[middle...length]
                 
        first_sorted_array = sort(first_array)
        second_sorted_array = sort(second_array)
         
        return merge(first_sorted_array, second_sorted_array)
    end
     
    def merge(first_array, second_array)

        return second_array if first_array.empty?
        return first_array if second_array.empty?
         
        if first_array.first <= second_array.first 
            unit = first_array.shift
        else
            unit = second_array.shift
        end    
     
        return [unit] + merge(first_array, second_array)
    end
end
print MergeSort.new.sort([4,1,6,3,5,2]) #=> [1, 2, 3, 4, 5, 6]
```

*This is the third post in a series of posts on various sorting algorithms in computer science. See the entire series <a href="/blog/categories/sorting-algorithms/">here</a>.*
---
layout: post
title: "All of the JavaScript: Basic terms and concepts for beginners"
date: 2014-10-06 18:27:45 -0400
comments: true
categories: [javascript]
published: true
---

When I first started learning JavaScript, I was thrown off by some of its terminology and quirks. This post is intended to offer some guidance into the craziness of the JavaScript world for beginning JavaScripters.

JavaScript is a dynamically-typed, object-oriented programming language that is usually used on the client side in web browsers. 

Functions are central to one's undertanding of JavaScript, so let's start with the difference between function declarations and function expressions.

<!-- more -->

##Function Declarations vs. Function Expressions

A <strong>function declaration</strong>, or function statement, is when you define a function without a variable assignment. A <strong>function expression</strong> is when you define a function and set the result of that function equal to a varialbe.

```java functions
 //Function Declaration

    //Named function
    function foo(){
      return "hello";
    } 

    foo() //=> "hello"

  // Function Expressions

    // Anonymous Function:
    var a = function(){
      return "hello";
    }

    a() //=> "hello"

    // Named Function:
    var a = function foo(){
      return "hello";
    }

    foo() //=> "hello"
    a() //=> "hello"

```

## Scoping

In JavaScript, you have <strong>global scope</strong> and <strong>local scope</strong>. If a variable is defined outside of any function, it is considering to be a global variable, which can be accessed by any function. It is scoped to the entire document.

If the variable is defined inside of a function, that variable is scoped to that function and is only accessible to that function.

```java Scope

  var a = 0; // This is a global variable.

  function foo(){
    var b = 1; // This is a local variable.
  }

  // If you try to call a and b outside of any function, you get:

  a //=> 0
  b //=> "b is undefined"
```

##Hoisting

One unique quirk in JavaScript is variable and function hoisting. Function   declarations and function variables are always moved to the top of their scope by the interpreter.

Since all variables defined in a function are scoped to the function level, any variables declared throughout the function are initialized as `undefined` at the beginning of the function. They are given a value when it reaches the variable assignment. Forward referencing is not possible for variables because <strong>the assignment itself isn't hoisted, just the initialization is</strong>.

However, forward referencing for function declarations is possible because placement is irrelevant for simple function declarations. All function declarations are automatically moved to the top of the function.

Let's look at some examples.

```java Function Hoisting

function foo(){
    function bar() {
        return "hi";
    }
    return bar();
    function bar() {
        return "bye";
    }
}

foo() //=> "bye"

/* Even though the second bar function declaration is below the 
return statement, the interpreter actually sees it above the return 
because it hoists all the function declarations to the top: */

function foo(){
    function bar() {
        return "hi";
    }
    function bar() {
        return "bye";
    } // redefines bar
    return bar();
}
```

```java Variable Hoisting

function foo(){
    var a = "hi";
    return a;
    var a = "bye";
}
foo() //=> "hi"

function foo(){
    return a;
    var a = "hi";
    var a = "bye";
}
foo() //=> "undefined"

// These are read like this:

function foo(){
    var a = "undefined"; // Variable in function initialized.
    var a = "hi"; // Variable assigned value.
    return a; // Current assignment "hi" returned.
    var a = "bye"; // Variable assignment redefined.  
}

function foo(){
    var a = "undefined"; // Variable in function initialized.
    return a; // Current assignment "undefined" returned.
    var a = "hi"; // Variable assignment.
    var a = "bye"; // Variable assignment redefined.
}

/* Further, if you simply redefine a variable inside a function,
that variable is a global variable which is initialized as undefined
in the document, like so: */

  function foo(){
    b = 1;
  }

  // is read as => 

  var b = "undefined"; // Variable initialized.

  function foo(){
    b = 1; // Variable reassigned.
  }

/* So it's important to inlclude `var` if you desire to limit 
the scope to the current function. */
```

To prevent variable hoising, you can use <strong>self-executing anonymous functions</strong>, also known as <strong>immediately-invoked function expressions (IIFEs)</strong>.

```java IIFEs
// Normal function:

var a = "hi";

var word = function(){
  return a; 
};

var a = "bye";

word() //=> "bye"

// IIFE: 

var a = "hi";

var word = (function(){
  return a; 
}(a));

var a = "bye";

word //=> "hi"

```

As you can see, IIFEs preserve the context of the origin function expression placement by passing the current state of the variable to the function.

##Object-Orientation

Coming from Ruby, I had a good understanding of OOP before learning JS. However, object-oriented programming in JavaScript is a bit different. 

You can create an object literal using a basic hash:

```java Object with literal notation 
var Amber = {name: "Amber", favoriteLanguage: "JavaScript"};
```

If you only need to ever use the object once, this technique is fine. But if you want to create multiple instances of it, you should use <strong>constructor functions</strong>. It is important to understand that <strong>all functions are objects in JavaScript</strong>. They all encapsulate a bit of reusable code.

In most languages, including Ruby, these functions are called classes, but in JavaScript you have constructor functions. 

```java Object with constructor

// Constructor Function
function Person (name, favoriteLanguage) {} 

// Particular instance of constructor function instantiated. 
var Amber = new Person("Amber", "JavaScript"); 
```

Now `Amber` is an object created from the `Person` object. The biggest advantage to using a constructor function over the basic hash above is that you can now reuse the Person function over and over again. You can give the Person function properties and methods, and those will be copied over to every instance of that object. 

The constructor function can now have properties:

```java Object with constructor and properties 
// Constructor Function
function Person (name, favoriteLanguage) {
  this.name = name;
  this.favoriteLanguage = favoriteLanguage;
  this.changeName = function(newName){
    this.name = newName;
  } 
} 

// Particular instance of constructor function instantiated. 
var Amber = new Person("Amber", "JavaScript"); 
Amber.name //=> "Amber"
Amber.changeName("Bethany") //=> Amber.name => "Bethany"
```

If you have a group of methods that you want every instance of the constructor function to inherit, you can also encapsulate those methods in a <strong>prototype</strong>.

```java Object with constructor and prototype
// Constructor Function
function Person (name, favoriteLanguage) {
  this.name = name;
  this.favoriteLanguage = favoriteLanguage;
} 

// Prototype 
Person.prototype = {
  constructor: Person,
  changeName: function(newName){
    this.name = newName;
  } 
}

//OR 

Person.prototype.constructor = Person;
Person.prototype.changeName = function(newName){
    this.name = newName;
} 
``` 

When you add functions to a prototype, they are only created once. And then everytime an instance calls one of those methods, the instance refers to the one created in the prototype. 

If you add functions to the constructor, they are duplicated every time you create a new instance of the constructor when is less efficient and consumes more memory. 

However, one plus to creating methods inside the constructor function is that those functions have access to private data (i.e. they are <em>privileged</em>), whereas functions in prototypes are not.

## Call vs Apply

If you would like to scope a function to an object, you can use the methods `call` and `apply`. For example, if you take the `changeName` function outside of the prototype in the sample above.

```java The Call Method

  function Person (name) {
    this.name = name;
  } 
  var Amber = new Person("Amber"); 

   var changeName = function(newName){
      this.name = newName;
    }

  /* Calling changeName() here will result in 'undefined' 
  because it doesn't know the scope of this. 
  You can bind a scope to a function with the call method. */

  // changeName.call(scope, arguments)

  changeName.call(Amber, "Bethany");
  Amber.name //=> "Bethany"

  /* This binds the function to the Amber object 
  and passes it the argument "Bethany". */

```
`apply` is very similar to `call`, except you pass it arguments as an array and it can take an unknown amount of arguments.

```java The Apply Method
  changeName.apply(Amber, ["Bethany"])
```

There are many intricacies I have not discussed here, but I hope this post gives you a taste of JavaScript and some of its basic concepts and quirks.
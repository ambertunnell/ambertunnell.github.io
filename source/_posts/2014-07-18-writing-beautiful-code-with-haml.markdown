---
layout: post
title: "Writing beautiful code with haml"
date: 2014-07-18 00:25:50 -0400
comments: true
categories: [haml, erb, html, beautiful code]
published: true
---

The more I code, the more I think of coding as an art form. Good code is easy to read by other humans, efficient, and easily adaptable. But great code is also elegant. When you look at a great piece of code, it feels <em>right</em>. Similarly, poorly written code, while often functional, just feels wrong and frustrating to look at. 

Writing view templates using [ERB](http://en.wikipedia.org/wiki/ERuby), the default Rails templating language, has always seemed unnecessarily messy to me. ERB tags do not flow well with Ruby code or HTML tags. They are time-consuming to write in code. You also cannot use the `command-slash` commenting shortcut in Sublime Text with them; you must comment out each line of Ruby code separately (which makes them even more time-consuming to maintain). 

Therefore, I was delighted when I discovered [HAML (HTML abstraction markup language)](http://haml.info/). A markup language that was designed to replace messy ERB templates with simpler, cleaner design. Why? Because markup should be beautiful.

<!-- more -->

While this idea may seem crazy to certain people, just take a look at the following basic forms, one written in basic HTML and one in HAML.

```html basic form_for with erb 
<%= form_for(@post) do |f| %>

  <div class="field">
    <%= f.label :name %>
    <%= f.text_field :name %>
    <%= f.label :content %>
    <%= f.text_area :content %>
  </div>

  <div class="field">
    <%= f.collection_check_boxes :tag_ids, Tag.all, :id, :name %>
  </div>

  <div class="field"> 
    <%= f.fields_for :tags, Tag.new do |tag_form| %> 
      <%= tag_form.label :name, "Name" %>
      <%= tag_form.text_field :name  %>
    <% end %> 
  </div>

  <div class="actions">
    <%= f.submit %>
  </div>

<% end %>
```

Here is the same exact form using HAML instead of ERB:

```ruby basic form_for with haml
= form_for(@post) do |f|
  .field
    = f.label :name
    = f.text_field :name
    = f.label :content
    = f.text_area :content
  .field
    = f.collection_check_boxes :tag_ids, Tag.all, :id, :name
  .field
    = f.fields_for :tags, Tag.new do |tag_form|
      = tag_form.label :name, "Name"
      = tag_form.text_field :name
  .actions
    = f.submit
```    

That's 44 percent fewer lines of code, with a cleaner and more elegant design that also took less time to write. You can also comment out the entire section with one command, if desired. (No more commenting out individual ERB lines again!)

##major pros
####Elegance.
It's shorter, cleaner, and way more beautiful than HTML.
####Faster.
No more time wasted writing those useless closing tags! No more time wasted commenting out separate lines of code! Allows developers to produce awesome projects faster.
####Closely related to CSS.
Your HTML code becomes more clearly associated with its CSS. Most useless HTML tags are gone, leaving simply the CSS relationships.
####Whitespace sensitive.
Everybody must have the same indentations and code form. This will force coders to adhere to standard practices, guaranteeing that others will be able to easily read their code. 

##major cons
####Whitespace sensitive.
You have to be extra careful with how you indent and write your code. This can be particularly frustrating for some people who would prefer not to have to follow a certain indentation practice or have to worry about whitespace. It can also be extremely hard to debug, since it's not always obvious if there's an extra whitespace in your code since you can't see it!
####Processing speed.
According to [this person](http://sephinrothcn.wordpress.com/2014/04/14/slim-vs-haml-performance-perspective/), HAML has a slightly slower processing speed than ERB (and SLIM, another markup language focusing on elegant design.)
####Cost of change.
Most people know HTML. Most people do not know HAML. It takes a bit of time to learn, when you can do the same things in HTML that you can do in HAML.

##change can be frustrating
...but it doesn't have to be!

Fortunately, if you do want to use HAML on a project going forward, there are handy websites like [Html2Haml](http://html2haml.heroku.com/) that will instantly convert ERB templates to HAML, hassle-free.

Just make sure you `gem install haml` and require HAML in your project. 

You can also create a new Rails app that uses HAML automatically with this command:

`rails new myapp -m https://raw.github.com/RailsApps/rails-composer/master/composer.rb`

After you run this command, you will be prompted for several preferences, including templating engine. Then, you can select ERB, HAML, or SLIM. If you choose HAML, it will automatically create your view files with the `.html.haml` extension.

Now go and produce prettier code with HAML!


###Additional Resources:
<li>[Haml gem on RubyGems](https://rubygems.org/gems/haml)</li>
<li>[Haml website](http://haml.info/)</li>
<li>Online HAML conversion: [Html2haml](http://html2haml.heroku.com/)</li>
<li>[Slim website](http://slim-lang.com/)</li>
<li>Online SLIM conversion: [Html2slim](http://html2slim.herokuapp.com/)</li>
<li>[Study on ERB, HAML, SLIM processing speed](http://sephinrothcn.wordpress.com/2014/04/14/slim-vs-haml-performance-perspective/)</li>

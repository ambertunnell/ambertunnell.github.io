---
layout: post
title: has_and_belongs_to_many 
subtitle: change in Rails 4 ActiveRecord associations
date: 2014-07-14 09:35:55 -0400
comments: true
categories: [Ruby, Ruby on Rails, Rails changes, ActiveRecord, Flatiron School] 
published: false
---

With Rails 4, there has been a change to the `has_and_belongs_to_many` ActiveRecord relationship. 

In the past, there have been two ways to declare a many-to-many relationship between models: `has_and_belongs_to_many` and `has_many, through:`. With `has_many, through:`, you have to explicitly declare a join model. While with `has_and_belongs_to_many`, the join model was implicit.

Now, with Rails 4, `has_and_belongs_to_many` has been deleted and is simply an alias for `has_many, through:`. This change forces developers to now always state the join model, just as you normally would with `has_many, through:`.

This change ultimately clears confusion and always for more versatility in development. 

<!-- more -->

Let's begin by looking at these scenarios more closely.

Here is HABTM, prior to Rails 4:

```ruby `has_and_belongs_to_many` prior to Rails 4
class Actor < ActiveRecord::Base
  has_and_belongs_to_many :movies
end 

class Movie < ActiveRecord::Base
  has_and_belongs_to_many :actors
end

#Implicitly, Rails creates the following:
# class ActorMovie
#   belongs_to :movie
#   belongs_to :actor
# end 
# Further, this assumed model must have a join table named `actors_movies`.
```

HABTM was particularly useful if you had no need to interact with the join model. Rails assumed it existed and you never had to create it yourself. 

But, with HABTM, Rails made certain assumptions about the join table name that the programmer had to be cognizant of. With the Actor and Movie Classes, the assumed join table would be `actors_movies`. It pluralizes the class names, and joins them in alphabetical order. So, if you added in a table called `movies_actors`, Rails would not recognize it as the join table for the Actor and Movies Classes. 

With Rails 4, the Powers That Be decided to eliminate HABTM and make it merely an alias for `has_many, through:`. In `has many, through:`, you have to explicitly state the join model, and you can name that model anything you choose. 

```ruby `has_many, through`

#Here are the models with the Rails standard naming conventions:
#This has a join table `actors_movies`

class Actor < ActiveRecord::Base
  has_many: :actors_movies
  has_many: :movies, through: :actors_movies
end

class Movie < ActiveRecord::Base
  has_many: :actors_movies
  has_many: :actors, through: :actors_movies
end 

class ActorMovie < ActiveRecord::Base
  belongs_to :movie
  belongs_to :actor
end 

#But, I could have named the join model anything I wanted, like so:
#This would have a join table `memberships`

class Actor < ActiveRecord::Base
  has_many: :memberships
  has_many: :movies, through: :memberships
end

class Movie < ActiveRecord::Base
  has_many: :memberships
  has_many: :actors, through: :memberships
end 

class Membership < ActiveRecord::Base
  belongs_to :movie
  belongs_to :actor
end 
```

`has many, through:` is particularly useful if you have any need to interact with the join model (for example, you wanted to add in validations, etc.) or if you just want the power to name the join table something more sensible than the combined class names. 

With Rails 4, you can still use HABTM if you desire, but you will have to add in the join model with the standard naming convention.

```ruby `has_and_belongs_to_many` after Rails 4
class Actor < ActiveRecord::Base
  has_and_belongs_to_many :movies
end 

class Movie < ActiveRecord::Base
  has_and_belongs_to_many :actors
end

class ActorMovie < ActiveRecord::Base
  belongs_to :movie
  belongs_to :actor
end 
```

This change is both good and bad. It causes more work for the developer, but it may clear up confusion by forcing developers to always add in a join model (as opposed to only in certain instances). Also, with this change, most developers will probably choose to simply use `has_many, through:` instead of HABTM which is less confusing and more versatile overall. 


###Additional Resources:
<li>[ActiveRecord Documentation](http://guides.rubyonrails.org/association_basics.html)</li>



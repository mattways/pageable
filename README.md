# Pagers

[![Gem Version](https://badge.fury.io/rb/pagers.svg)](http://badge.fury.io/rb/pagers) [![Code Climate](https://codeclimate.com/github/museways/pagers/badges/gpa.svg)](https://codeclimate.com/github/museways/pagers) [![Build Status](https://travis-ci.org/museways/pagers.svg?branch=3.0.3)](https://travis-ci.org/museways/pagers)

Minimalistic pagers inspired in kaminari and will_paginate for rails.

# Install

Put this line in your Gemfile:

    gem 'pagers'

Then bundle:

    $ bundle

# Configuration

Generate the configuration file:
```ruby
rails g pagers:install
```

NOTE: This will generate the config/initializers/pagers.rb.

# Usage

Call the page scope from your models:
```ruby
@collection = Model.page(1, length: 10, padding: 4)
```

And in your views just:
```ruby
<%= paginate @collection %>
```

NOTE: You can override the parameters in the paginate method.

# Credits

This gem is maintained and funded by [museways](http://museways.com).

# License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.

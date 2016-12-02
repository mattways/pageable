[![Gem Version](https://badge.fury.io/rb/pagers.svg)](http://badge.fury.io/rb/pagers)
[![Code Climate](https://codeclimate.com/github/mmontossi/pagers/badges/gpa.svg)](https://codeclimate.com/github/mmontossi/pagers)
[![Build Status](https://travis-ci.org/mmontossi/pagers.svg)](https://travis-ci.org/mmontossi/pagers)
[![Dependency Status](https://gemnasium.com/mmontossi/pagers.svg)](https://gemnasium.com/mmontossi/pagers)

# Pagers

Minimalistic pagers inspired in kaminari and will_paginate for rails.

## Why

I did this gem to:

- .

## Install

Put this line in your Gemfile:
```ruby
gem 'pagers'
```

Then bundle:
```
$ bundle
```

## Configuration

Generate the configuration file:
```
rails g pagers:install
```

The defaults values are:
```ruby
Pagers.configure do |config|

  config.length = 20
  config.padding = 0
  config.links = 5

end
```

## Usage

### Relation

Call the page scope from your models:
```ruby
@collection = Model.page(1, length: 10, padding: 4)
```

### Views

And in your views just:
```erb
<%= paginate @collection %>
```

NOTE: You can override the parameters in the scope and in the helper.

### SEO

You can add the parameter to paths:
```ruby
get 'search/:query/(:page)' => 'products#search'
```

To produce routes like:
```
search/sample
search/sample/2
search/sample/3
.
.
.
```

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.

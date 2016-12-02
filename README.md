[![Gem Version](https://badge.fury.io/rb/pagers.svg)](http://badge.fury.io/rb/pagers)
[![Code Climate](https://codeclimate.com/github/mmontossi/pagers/badges/gpa.svg)](https://codeclimate.com/github/mmontossi/pagers)
[![Build Status](https://travis-ci.org/mmontossi/pagers.svg)](https://travis-ci.org/mmontossi/pagers)
[![Dependency Status](https://gemnasium.com/mmontossi/pagers.svg)](https://gemnasium.com/mmontossi/pagers)

# Pagers

Scope based pagination engine for rails.

## Why

I did this gem to:

- Simplify code by keep close integration with rails.
- Have most common used settings set out of the box.
- Create a compatible pagination for [indexes gem](https://github.com/mmontossi/indexes).

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
$ bundler exec rails g pagers:install
```

Set the global settings:
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
@products = Product.page(1)
```

You can override global options by passing a hash:
```ruby
@products = Product.page(1, length: 10, padding: 4)
```

### Views

You can use paginate helper to generate a pager html:
```erb
<%= paginate @collection %>
```

### SEO

If you want to remove the page query parameter, add an optional parameter to the route:
```ruby
get 'search/:query/(:page)' => 'products#search'
```

That will produce links like this:
```
search/sample
search/sample/2
search/sample/3
```

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_pagination/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails-pagination"
  s.version     = RailsPagination::VERSION
  s.authors     = ["Mattways"]
  s.email       = ["contact@mattways.com"]
  s.homepage    = "https://github.com/mattways/rails-pagination"
  s.summary     = "Another pagination alternative."
  s.description = "Inspired in Kaminari and will_paginate with some extra handy methods and only for rails."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"

  s.add_development_dependency "sqlite3"
end

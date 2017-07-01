$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'pagers/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'pagers'
  s.version     = Pagers::VERSION
  s.authors     = ['mmontossi']
  s.email       = ['mmontossi@museways.com']
  s.homepage    = 'https://github.com/mmontossi/pagers'
  s.summary     = 'Pagers for rails.'
  s.description = 'Scope based pagination engine for rails.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1'

  s.add_development_dependency 'pg', '~> 0.21'
end

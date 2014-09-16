require 'rails/generators'

module Pagers
  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def create_initializer
      copy_file 'pagers.rb', 'config/initializers/pagers.rb'
    end

  end
end

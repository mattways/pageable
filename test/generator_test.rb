require 'test_helper'
require 'rails/generators'
require 'generators/pagers/install_generator'

class GeneratorsTest < Rails::Generators::TestCase
  tests Pagers::InstallGenerator
  destination File.expand_path('../tmp', File.dirname(__FILE__))

  teardown do
    FileUtils.rm_rf self.destination_root
  end

  test 'initializer generator' do
    run_generator
    assert_file 'config/initializers/pagers.rb'
  end

end

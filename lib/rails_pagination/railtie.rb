module RailsPagination
  class Railtie < Rails::Railtie

    config.pagination = ActiveSupport::OrderedOptions.new
    config.pagination.default_per_page = 30
  
  end
end
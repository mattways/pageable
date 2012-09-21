module RailsPagination
  class Railtie < Rails::Railtie

    config.pagination = ActiveSupport::OrderedOptions.new
    config.pagination.per_page = 30
  
  end
end
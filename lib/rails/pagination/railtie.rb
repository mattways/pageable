module Rails
  module Pagination
    class Railtie < Rails::Railtie

      config.pagination = ActiveSupport::OrderedOptions.new
      config.pagination.default_per_page = 30
      config.pagination.default_parameter = :p
      config.pagination.default_navigation = 5

      initializer 'pagination.helpers' do
        ::ActiveRecord::Base.send :extend, Rails::Pagination::ActiveRecord
        ActionView::Base.send :include, Rails::Pagination::Helpers
      end

    end
  end
end

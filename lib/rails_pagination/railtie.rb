module RailsPagination
  class Railtie < Rails::Railtie

    config.pagination = ActiveSupport::OrderedOptions.new
    config.pagination.default_per_page = 30
    config.pagination.default_parameter = :p
    config.pagination.default_navigation = 5

    initializer 'rails_pagination' do
      ::ActiveRecord::Base.send :extend, RailsPagination::ActiveRecord::Base
      ::ActionView::Base.send :include, RailsPagination::ActionView::Base
    end

  end
end

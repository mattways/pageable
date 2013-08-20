module Pageable
  class Railtie < Rails::Railtie

    config.pagination = ActiveSupport::OrderedOptions.new
    config.pagination.default_per_page = 30
    config.pagination.default_parameter = :p
    config.pagination.default_navigation = 5

    initializer 'pageable' do
      ::ActiveRecord::Base.send :include, Pageable::ActiveRecord::Base
      ::ActionView::Base.send :include, Pageable::ActionView::Base
    end

  end
end

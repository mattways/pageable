module Pagers
  class Railtie < Rails::Railtie

    initializer 'pagers' do
      ::ActiveRecord::Base.send :include, Pagers::ActiveRecord::Base
      ::ActionView::Base.send :include, Pagers::ActionView::Base
    end

  end
end

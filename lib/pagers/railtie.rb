module Pagers
  class Railtie < Rails::Railtie

    initializer :pagers do
      ::ActiveRecord::Base.include(
        Pagers::Extensions::ActiveRecord::Base
      )
      ::ActionView::Base.include(
        Pagers::Extensions::ActionView::Base
      )
    end

  end
end

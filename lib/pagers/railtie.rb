module Pagers
  class Railtie < Rails::Railtie

    initializer 'pagers.active_record' do
      ActiveRecord.on_load :active_record do
        ::ActiveRecord::Base.include(
          Pagers::Extensions::ActiveRecord::Base
        )
      end
    end

    initializer 'pagers.action_view' do
      ActiveRecord.on_load :action_view do
        ::ActionView::Base.include(
          Pagers::Extensions::ActionView::Base
        )
      end
    end

  end
end

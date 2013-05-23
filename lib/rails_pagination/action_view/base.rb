module RailsPagination
  module ActionView
    module Base

      def paginate(*args)
        Pager.new *args.unshift(self)
      end

      def pager(collection)
        render partial: 'rails_pagination/pager', locals: { collection: collection }
      end

    end
  end
end

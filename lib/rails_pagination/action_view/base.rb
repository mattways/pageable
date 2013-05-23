module RailsPagination
  module ActionView
    module Base

      def paginate(*args)
        Pagination.new *args.unshift(request)
      end

      def pager(*args)
        render partial: 'rails_pagination/pager', locals: { pagination: paginate(*args) }
      end

    end
  end
end

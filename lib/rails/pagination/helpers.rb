module Rails
  module Pagination
    module Helpers

      def paginate(*args)
        Pager.new *args.unshift(self)
      end

    end
  end
end

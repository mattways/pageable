module RailsPagination
  module ActionView
    module Base

      def paginate(*args)
        Pager.new *args.unshift(self)
      end

    end
  end
end

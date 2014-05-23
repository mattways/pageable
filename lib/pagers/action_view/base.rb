module Pagers
  module ActionView
    module Base
      extend ActiveSupport::Concern

      def page_path(page, options={})
        parameter = options[:parameter] || Rails.application.config.pagers.parameter
        request.path + '?' + request.query_parameters.merge(parameter => page).to_query
      end

      def paginate(collection, options={})
        pages = options[:pages] || Rails.application.config.pagers.pages
        if collection.total_pages >= pages
          middle = (pages / 2).ceil
          if collection.current_page > (collection.total_pages - middle)
            starts_at = collection.total_pages - pages + 1
            ends_at = collection.total_pages
          elsif collection.current_page <= middle
            starts_at = 1
            ends_at = pages
          else
            starts_at = collection.current_page - middle
            ends_at = collection.current_page + middle
          end
        else
          starts_at = 1
          ends_at = collection.total_pages
        end
        render partial: 'pagers/main', locals: {
          collection: collection,
          options: options,
          pages: Range.new(starts_at, ends_at),
          less_pages: starts_at > 1,
          more_pages: ends_at < collection.total_pages
        }
      end

    end
  end
end

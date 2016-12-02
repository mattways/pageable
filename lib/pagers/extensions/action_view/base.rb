module Pagers
  module Extensions
    module ActionView
      module Base
        extend ActiveSupport::Concern

        def page_path(number, options={})
          if number == 1
            number = nil
          end
          url_for request.query_parameters.merge(page: number)
        end

        def paginate(collection, options={})
          links = (options[:links] || Pagers.configuration.links)
          if collection.total_pages >= links
            middle = (links / 2).ceil
            if collection.current_page > (collection.total_pages - middle)
              starts_at = (collection.total_pages - links + 1)
              ends_at = collection.total_pages
            elsif collection.current_page <= middle
              starts_at = 1
              ends_at = links
            else
              starts_at = (collection.current_page - middle)
              ends_at = (collection.current_page + middle)
            end
          else
            starts_at = 1
            ends_at = collection.total_pages
          end
          pages = Range.new(starts_at, ends_at)
          less_pages = (starts_at > 1)
          more_pages = (ends_at < collection.total_pages)
          render(
            'pagers/main',
            collection: collection,
            pages: pages,
            less_pages: less_pages,
            more_pages: more_pages,
            options: options
          )
        end

      end
    end
  end
end

module RailsPagination
  module ActionView
    module BaseMethods

      def paginate(*args)
        Pager.new *args.unshift(self)
      end
      
      class Pager
        
        def initialize(*args)
          options = args.extract_options!
          @template = args[0]
          @collection = args[1]
          @parameter = options[:parameter] ? options[:parameter] : :p 
          @navigation = Navigation.new(args[1], options[:navigation] ? options[:navigation] : 5)
        end

        def has_multiple_pages?
          @has_multiple_pages ||= @collection.total_pages > 1
        end

        def is_current_page?(page)
          @collection.current_page == page
        end

        def has_previous_page?
          @has_previous_page ||= @collection.previous_page != nil
        end         
        
        def has_next_page?
          @has_next_page ||= @collection.next_page != nil
        end
        
        def has_first_page?
          @collection.current_page > 1 and @collection.total_pages > 1
        end
        
        def is_first_page?
          @is_first_page ||= @collection.current_page == 1
        end

        def has_last_page?
          @collection.current_page != @collection.last_page and @collection.total_pages > 1
        end

        def is_last_page?
          @is_last_page ||= @collection.current_page == total_pages
        end

        def navigation
          @navigation
        end

        def page_path(page)
          @template.url_for(@template.request.query_parameters.merge(@parameter => page))
        end

        def page_url(page)
          @template.url_for(@template.request.query_parameters.merge(@parameter => page, :only_path => false))
        end

        def current_page_path
          page_path @collection.current_page
        end

        def current_page_url
          page_url @collection.current_page
        end

        def first_page_path
          page_path @collection.first_page
        end

        def first_page_url
          page_url @collection.first_page
        end

        def previous_page_path
          page_path @collection.previous_page
        end

        def previous_page_url
          page_url @collection.previous_page
        end

        def next_page_path
          page_path @collection.next_page
        end

        def next_page_url
          page_url @collection.next_page
        end

        def last_page_path
          page_path @collection.last_page
        end

        def last_page_url
          page_url @collection.last_page
        end

      end

      class Navigation

        def initialize(collection, length)
          if collection.total_pages >= length
            middle = (length / 2).ceil
            if collection.current_page > collection.total_pages - middle
              starts_at = collection.total_pages - length + 1
              ends_at = collection.total_pages
            elsif collection.current_page <= middle
              starts_at = 1
              ends_at = length
            else
              starts_at = collection.current_page - middle
              ends_at = collection.current_page + middle
            end
          else
            starts_at = 1
            ends_at = collection.total_pages
          end
          @has_less_pages = starts_at > 1
          @has_more_pages = ends_at < collection.total_pages
          @pages = Range.new(starts_at, ends_at) 
        end 

        def has_less_pages?
          @has_less_pages
        end

        def has_more_pages?
          @has_more_pages
        end

        def pages
          @pages
        end

      end

    end
  end
end

ActionView::Base.send :include, RailsPagination::ActionView::BaseMethods

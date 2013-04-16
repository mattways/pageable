module RailsPagination
  class Pager
    
    def initialize(*args)
      options = args.extract_options!
      @template = args[0]
      @collection = args[1]
      @parameter = options[:parameter] || Rails.application.config.pagination.default_parameter 
      @navigation = Navigation.new(args[1], options[:navigation] || Rails.application.config.pagination.default_navigation)
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
      @template.request.path + (@template.request.query_parameters.any? ? "?#{@template.request.query_parameters.merge(@parameter => page).to_query}" : '')
    end

    def page_url(page)
      @template.request.protocol + @template.request.host + page_path(page)
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
end

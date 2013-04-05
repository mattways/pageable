module RailsPagination
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

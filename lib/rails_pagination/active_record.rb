module RailsPagination
  module ActiveRecord
    module BaseMethods
        
      def page(number)
        r = limit(per_page).offset(per_page * ([number.to_i, 1].max - 1))
        r.extending(RailsPagination::ActiveRecord::RelationMethods)
      end
    
      def per_page
        defined?(@per_page) ? @per_page : Rails.application.config.pagination.per_page 
      end

      def per_page(value)
        value = [value.to_i, 1].max
        @per_page = value
      end
    
    end
    module RelationMethods
      
      def per(number)
        number = [number.to_i, 1].max
        limit(number).offset(number * (offset_value / limit_value))
      end      
      
      def total_count
        @total_count ||= begin
          c = except(:offset, :limit, :order)
          c = c.except(:includes) unless references_eager_loaded_tables?
          uses_distinct_sql_statement = c.to_sql =~ /DISTINCT/i
          if uses_distinct_sql_statement
            c.length
          else
            c = c.count
            c.respond_to?(:count) ? c.count : c
          end
        end
      end            
      
      def total_pages
        @total_pages ||= (total_count.to_f / limit_value).ceil
      end
      
      def has_multiple_pages?
        @has_multiple_pages ||= total_pages > 1
      end

      def current_page
        @current_page ||= (offset_value / limit_value) + 1
      end
      
      def is_current_page?(page)
        current_page == page
      end

      def previous_page
        @previous_page ||= current_page > 1 ? (current_page - 1) : nil
      end
      
      def has_previous_page?
        @has_previous_page ||= previous_page != nil
      end      

      def next_page
        @next_page ||= current_page < total_pages ? (current_page + 1) : nil
      end
      
      def has_next_page?
        @has_next_page ||= next_page != nil
      end
      
      def first_page
        1
      end
      
      def has_first_page?
        current_page > 1 and total_pages > 1
      end
      
      def is_first_page?
        @is_first_page ||= current_page == 1
      end
    
      def last_page
        total_pages
      end      
      
      def has_last_page?
        current_page != last_page and total_pages > 1
      end

      def is_last_page?
        @is_last_page ||= current_page == total_pages
      end    

      def out_of_bounds?
        @out_of_bounds ||= current_page > total_pages or current_page < total_pages
      end    
      
      def navigation_options(length=3)
        length = [length.to_i, 2].max
        if total_pages >= length
          middle = (length / 2).ceil
          if current_page > (total_pages - middle)
            starts_at = (total_pages - length) + 1
            ends_at = total_pages
          elsif current_page <= middle
            starts_at = 1
            ends_at = length
          else
            starts_at = current_page - middle
            ends_at = current_page + middle
          end
        else
          starts_at = 1
          ends_at = total_pages
        end
        {
          :less_pages? => starts_at > 1,
          :more_pages? => ends_at < total_pages,
          :range => Range.new(starts_at, ends_at)
        }
      end        
      
    end
  end
end

ActiveRecord::Base.send :extend, RailsPagination::ActiveRecord::BaseMethods

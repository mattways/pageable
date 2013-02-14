module RailsPagination
  module ActiveRecord
    module BaseMethods   
      
      def inherited(subclass)
        if subclass.superclass == ::ActiveRecord::Base
          subclass.scope :page, Proc.new {|number|
            subclass.limit(subclass.default_per_page).offset(subclass.default_per_page * ([number.to_i, 1].max - 1))
          } do
            include RailsPagination::ActiveRecord::RelationMethods
          end
        end       
      end

      def default_per_page(value=nil)
        unless value.nil?
          value = [value.to_i, 1].max
          @default_per_page = value
        end
        defined?(@default_per_page).nil? ? Rails.application.config.pagination.default_per_page : @default_per_page 
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
        custom_limit = (current_page > 0 and offset_value > 0) ? (offset_value / (current_page-1)) : false
        @total_pages ||= [(((total_count.to_f - (((current_page-1) * limit_value) - offset_value)) / (custom_limit ? custom_limit : limit_value))).ceil, 1].max
      end

      def current_page
        @current_page ||= (offset_value.to_f / limit_value).ceil + 1
      end

      def previous_page
        @previous_page ||= current_page > 1 ? (current_page - 1) : nil
      end
      
      def next_page
        @next_page ||= current_page < total_pages ? (current_page + 1) : nil
      end
      
      def first_page
        1
      end
      
      def last_page
        total_pages
      end      
      
      def out_of_bounds?
        @out_of_bounds ||= current_page > total_pages or current_page < first_page
      end    
      
    end
  end
end

ActiveRecord::Base.send :extend, RailsPagination::ActiveRecord::BaseMethods

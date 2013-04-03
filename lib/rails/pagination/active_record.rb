module Rails
  module Pagination
    module ActiveRecord

      def inherited(subclass)
        if subclass.superclass == ::ActiveRecord::Base
          subclass.scope :page, Proc.new {|number|
            subclass.limit(subclass.default_per_page).offset(subclass.default_per_page * ([number.to_i, 1].max - 1))
          } do
            include Rails::Pagination::Relation
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
  end
end

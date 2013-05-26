module RailsPagination
  module ActiveRecord
    module Base

      def inherited(subclass)
        subclass.class_eval do
          if superclass == ::ActiveRecord::Base
            scope :page, Proc.new { |number|
              limit(default_per_page).offset(default_per_page * ([number.to_i, 1].max - 1))
            } do
              include RailsPagination::ActiveRecord::Relation
            end
          end
        end
        super
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

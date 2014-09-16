module Pagers
  module ActiveRecord
    module Base
      extend ActiveSupport::Concern
      module ClassMethods

        def inherited(subclass)
          subclass.class_eval do
            if superclass == ::ActiveRecord::Base
              scope :page, ->(number, options={}) {
                length = options[:length] || Pagers.config.length
                padding = options[:padding] || Pagers.config.padding
                current_page = [number.to_i, 1].max
                offset_value = (length * (current_page - 1)) + padding
                limit_value = length
                values = Module.new do
                  define_method :padding do
                    padding
                  end
                  define_method :page_length do
                    length
                  end
                  define_method :current_page do
                    current_page
                  end
                end
                limit(limit_value).offset(offset_value).extending(Pagers::ActiveRecord::Relation, values)
              }
            end
          end
          super
        end

      end
    end
  end
end

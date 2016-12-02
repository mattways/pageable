module Pagers
  module Extensions
    module ActiveRecord
      module Base
        extend ActiveSupport::Concern

        module ClassMethods

          def inherited(subclass)
            subclass.class_eval do
              if superclass == ::ActiveRecord::Base
                scope :page, ->(number, options={}) {
                  padding = (options[:padding] || Pagers.configuration.padding)
                  length = (options[:length] || Pagers.configuration.length)
                  current_page = [number.to_i, 1].max
                  limit = length
                  offset = ((length * (current_page - 1)) + padding)
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
                  limit(limit).offset(offset).extending(
                    Pagers::Extensions::ActiveRecord::Relation,
                    values
                  )
                }
              end
            end
            super
          end
        end

      end
    end
  end
end

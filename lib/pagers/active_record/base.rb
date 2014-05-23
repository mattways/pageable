module Pagers
  module ActiveRecord
    module Base
      extend ActiveSupport::Concern

      module ClassMethods

        def inherited(subclass)
          subclass.class_eval do
            if superclass == ::ActiveRecord::Base
              scope :page, ->(number, options={}) {
                length = options[:length] || Rails.application.config.pagers.length
                padding = options[:padding] || Rails.application.config.pagers.padding
                current_page = [number.to_i, 1].max
                offset_value = (length * (current_page - 1)) + (current_page == 1 ? padding : 0)
                limit_value = length - (current_page == 1 ? padding : 0)
                limit(limit_value).offset(offset_value).extending(Pagers::ActiveRecord::Relation).tap do |relation|
                  relation.instance_variable_set :@padding, padding
                  relation.instance_variable_set :@length, length
                  relation.instance_variable_set :@current_page, current_page
                end
              }
            end
          end
          super
        end

      end
    end
  end
end

module Pageable
  module ActionView
    module Base
      extend ActiveSupport::Concern

      def page_path(page, options = {})
        parameter = options[:parameter] || Rails.application.config.pagination.default_parameter
        request.path + '?' + request.query_parameters.merge(parameter => page).to_query
      end

      def pager(relation, options = {})
        navigation = options[:navigation] || Rails.application.config.pagination.default_navigation
        if relation.total_pages >= navigation
          middle = (navigation / 2).ceil
          if relation.current_page > relation.total_pages - middle
            starts_at = relation.total_pages - navigation + 1
            ends_at = relation.total_pages
          elsif relation.current_page <= middle
            starts_at = 1
            ends_at = navigation
          else
            starts_at = relation.current_page - middle
            ends_at = relation.current_page + middle
          end
        else
          starts_at = 1
          ends_at = relation.total_pages
        end
        render partial: 'pageable/pager', locals: {
          relation: relation,
          options: options,
          pages: Range.new(starts_at, ends_at),
          less_pages: starts_at > 1,
          more_pages: ends_at < relation.total_pages
        }
      end

    end
  end
end

module Pagers
  module ActiveRecord
    module Relation
      extend ActiveSupport::Concern

      def total_pages
        @total_pages ||= [(total_count / @length.to_f).ceil, 1].max
      end

      def current_page
        @current_page
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
        @out_of_bounds ||= (current_page > total_pages || current_page < first_page)
      end
 
      def total_count
        @total_count ||= begin
          r = except(:limit, :offset, :order, :reorder)
          r = r.except(:includes) unless references_eager_loaded_tables?
          r = r.count
          r.respond_to?(:count) ? r.count : r
        end
      end

    end
  end
end

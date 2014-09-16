require 'pagers/action_view/base'
require 'pagers/active_record/base'
require 'pagers/active_record/relation'
require 'pagers/engine'
require 'pagers/railtie'

module Pagers
  class << self

    def configure
      yield config
    end

    def config
      @config ||= begin
        ActiveSupport::OrderedOptions.new.tap do |config|
          config.length = 20
          config.padding = 0
          config.parameter = :page
          config.pages = 5
        end
      end
    end

  end
end

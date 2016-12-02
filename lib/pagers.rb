require 'pagers/extensions/action_view/base'
require 'pagers/extensions/active_record/base'
require 'pagers/extensions/active_record/relation'
require 'pagers/configuration'
require 'pagers/engine'
require 'pagers/railtie'
require 'pagers/version'

module Pagers
  class << self

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end

  end
end

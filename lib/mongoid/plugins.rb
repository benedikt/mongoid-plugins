module Mongoid
  module Plugins
    extend ActiveSupport::Concern

    included do
      cattr_accessor :_plugin_options
      self._plugin_options = {}
    end

    module ClassMethods
      def plugin(mod, &block)
        _plugin_options[mod] = ActiveSupport::OrderedOptions.new.tap do |options|
          options.merge!(mod.default_plugin_options) if mod.respond_to? :default_plugin_options
          yield(options) if block_given?
        end

        include(mod)
      end

      def plugin_options_for(mod)
        raise "#{mod} is not loaded as a plugin" unless _plugin_options.include?(mod)
        _plugin_options[mod]
      end
    end
  end
end

module Mongoid
  module Document
    include Mongoid::Plugins
  end
end

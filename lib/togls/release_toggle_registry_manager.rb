module Togls
  # Release Toggle Registry Manager
  #
  # This is the primary DSL interface. It provides a DSL to facilitate housing
  # and managing a toggle registry.
  module ReleaseToggleRegistryManager
    def self.included(mod)
      mod.extend(ClassMethods)
    end

    # Release Toggle Registry Manager Class Methods
    #
    # The class methods that should be extended onto the module/class when
    # ReleaseToggleRegistryManager is included.
    module ClassMethods
      def features(&block)
        if @feature_toggle_registry.nil?
          @feature_toggle_registry = FeatureToggleRegistry.new
        end

        @feature_toggle_registry.expand(&block) if block

        @feature_toggle_registry
      end

      def features=(feature_toggle_registry)
        @feature_toggle_registry = feature_toggle_registry
      end

      def feature(key)
        if @feature_toggle_registry.nil?
          @feature_toggle_registry = FeatureToggleRegistry.new
        end

        @feature_toggle_registry.get(key)
      end

      def logger
        @logger ||= Logger.new(STDOUT)
      end
    end
  end
end
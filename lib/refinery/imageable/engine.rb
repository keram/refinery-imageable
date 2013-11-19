require 'refinery/imageable/configuration'

module Refinery
  module Imageable
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery

      engine_name :refinery_imageable

      initializer "register refinery_imageable plugin" do
        Refinery::Core.config.register_admin_javascript 'refinery/imageable'
        Refinery::Core.config.register_admin_stylesheet 'refinery/imageable'
      end

      initializer "monkey patch imageables" do
        require 'refinery/imageable/extension'

        Refinery::Imageable.imageables.each do |imageable|
          require "refinery/imageable/#{imageable}"
        end

        ActiveSupport.on_load(:active_record) do
          Refinery::Imageable.monkey_patch_imageables
        end

        # Ensure that in dev mode after reload are imageables patched again
        ActionDispatch::Callbacks.to_prepare do
          Refinery::Imageable.monkey_patch_imageables
        end
      end

      config.after_initialize do
        Refinery.register_engine Refinery::Imageable
      end
    end
  end
end

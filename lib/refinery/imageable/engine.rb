require 'refinery/imageable/configuration'

module Refinery
  module Imageable
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery

      engine_name :refinery_imageable

      def self.register(tab)
        tab.name = 'imageable'
        tab.partial = '/refinery/admin/imagenization/tabs/images'
      end

      initializer "register refinery_imageable plugin" do
        Refinery::Core.config.register_admin_javascript 'refinery/imageable'
        Refinery::Core.config.register_admin_stylesheet 'refinery/imageable'
      end

      initializer "require and attach imageables" do
        ActiveSupport.on_load(:active_record) do
          require 'refinery/imageable/extension'
          #Refinery::Image.send :belongs_to, :imageable, dependent: :destroy
          #
          #Refinery::Image.send :delegate [:alt, :caption], to: :image

          Refinery::Image.module_eval do
          #  has_many :imagenizations, dependent: :destroy, foreign_key: :image_id
          end


          Refinery::Imageable.imageables.each do |imageable|
            require "refinery/imageable/#{imageable}"
          end
        end
      end

      config.after_initialize do
        Refinery::Pages::Tab.register do |tab|
          register tab
        end

        if defined?(Refinery::Blog::Tab)
          Refinery::Blog::Tab.register do |tab|
            register tab
          end
        end

        Refinery.register_engine Refinery::Imageable
      end
    end
  end
end

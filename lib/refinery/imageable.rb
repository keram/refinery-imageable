require 'refinerycms-core'

module Refinery
  autoload :ImageableGenerator, 'generators/refinery/imageable_generator'

  module Imageable

    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def monkey_patch_imageables

        Refinery::Image.class_eval do
          has_many :imagenizations, dependent: :destroy, as: :image

          delegate :featured, to: :imagenizations
        end

        imageables.each do |imageable|
          "Refinery::Imageable::#{imageable.camelize}".constantize.patch
        end
      end
    end

    require 'refinery/imageable/engine'
  end
end

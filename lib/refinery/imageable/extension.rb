require 'refinery/image'

module Refinery
  module Imageable
    module Extension

      def is_imageable
        has_many :imagenizations, dependent: :destroy, as: :imageable
        has_many :images, through: :imagenizations

        accepts_nested_attributes_for :imagenizations, allow_destroy: true
      end

    end
  end
end

ActiveRecord::Base.send(:extend, Refinery::Imageable::Extension)

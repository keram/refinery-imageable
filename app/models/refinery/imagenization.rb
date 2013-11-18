module Refinery
  class Imagenization < Refinery::Core::BaseModel

    belongs_to :image
    belongs_to :imageable, polymorphic: true

    accepts_nested_attributes_for :image, allow_destroy: false

    before_create { |item|
      item.position = item.imageable.images.count if item.position.blank?
    }

    default_scope { order('refinery_imagenizations.position ASC')}
  end
end

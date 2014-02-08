module Refinery
  module Imageable
    include ActiveSupport::Configurable

    config_accessor :imageables, :featured_image_options

    self.imageables = %w(page)

    self.featured_image_options = {
      default: {
        geometry: '960x',
        caption: true
      }
    }

  end
end

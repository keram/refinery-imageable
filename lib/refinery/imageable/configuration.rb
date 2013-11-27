module Refinery
  module Imageable
    include ActiveSupport::Configurable

    config_accessor :imageables, :imageables_image_options

    self.imageables = %w(page blog_post)

    self.imageables_image_options = {
      page: {
        before_body: {
          geometry: '700x',
          caption: true
        }
      }
    }

  end
end

module Refinery
  module Imageable
    include ActiveSupport::Configurable

    config_accessor :imageables

    self.imageables = %w(page blog_post)

  end
end

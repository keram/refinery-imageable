module Refinery
  class ImageableGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def rake_db
      rake('refinery_imageable:install:migrations')
    end

    def generate_imageable_initializer
      template 'config/initializers/refinery/imageable.rb.erb', File.join(destination_root, 'config', 'initializers', 'refinery', 'imageable.rb')
    end

  end
end

module Refinery
  class ImageableGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def rake_db
      rake('refinery_imageable:install:migrations')
    end

    def generate_imageable_initializer
      template 'config/initializers/refinery/imageable.rb.erb', File.join(destination_root, 'config', 'initializers', 'refinery', 'imageable.rb')
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', verbose: true do
        <<-EOH

# Added by Refinery CMS Imageable extension
Refinery::Imageable::Engine.load_seed
        EOH
      end
    end
  end
end

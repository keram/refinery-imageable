require 'refinerycms-core'

module Refinery
  autoload :ImageableGenerator, 'generators/refinery/imageable_generator'

  module Imageable

    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end
    end

    require 'refinery/imageable/engine'
  end
end

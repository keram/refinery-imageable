module Refinery
  module Imageable
    module BlogPost
      def self.patch
        require 'refinery/blog' unless defined?(Refinery::Blog)

        Refinery::Blog::Post.send :is_imageable

        Refinery::Blog::Post.class_eval do
          def featured_image
            @featured_image ||= imagenizations.featured.first.image if imagenizations.featured.any?
          end

          def opengraph_image
            featured_image.thumbnail(geometry: :medium).url if featured_image.present?
          end
        end

        Refinery::Admin::Blog::PostsController.class_eval do
          private

          def permitted_post_params_with_imagenization
            @permitted_post_params ||= permitted_post_params_without_imagenization +
                        [imagenizations_attributes: [:id, :image_id, :featured, :position, image_attributes: [:id, :alt, :caption]]]
          end

          alias_method_chain :permitted_post_params, :imagenization
        end

        Refinery::Blog::PostsPreviewController.class_eval do
          private

          def permitted_post_params_with_imagenization
            @permitted_post_params ||= permitted_post_params_without_imagenization +
                        [imagenizations_attributes: [:id, :image_id, :featured, :position, image_attributes: [:id, :alt, :caption]]]
          end

          alias_method_chain :permitted_post_params, :imagenization
        end

        Refinery::Blog::Posts::Tab.register do |tab|
          tab.name = 'imageable'
          tab.partial = '/refinery/admin/imagenization/tabs/images'
        end unless Refinery::Blog::Posts.tabs.collect(&:name).include?('imageable')
      end
    end
  end
end

module Refinery
  module Imageable
    module BlogPost
      class << self
        def patch
          require 'refinery/blog' unless defined?(Refinery::Blog)

          # This may looks akward, but when table doesn't exists
          # at least mysql2 gem throws exception because table doesn't exist
          # (pure Catch-22 .)
          # todo: explore more and solve with nicer solution
          return unless Refinery::Blog::Post.table_exists? rescue return

          patch_model
          patch_controllers
          patch_presenters_views
        end

        private

        def patch_model
          Refinery::Blog::Post.send :is_imageable

          Refinery::Blog::Post.class_eval do
            def featured_image
              @featured_image ||= imagenizations.featured.first.image if imagenizations.featured.any?
            end

            def opengraph_image
              featured_image.thumbnail(geometry: :medium).url if featured_image.present?
            end
          end
        end

        def patch_controllers
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
        end

        def patch_presenters_views
          options = Refinery::Imageable.imageables_image_options[:blog_post] || {}

          Refinery::Blog::Posts.add_section_extra :before, :body, :imageable_images do |page|
            Refinery::ImageableImagesPresenter.new(page, (options[:before_body] || {}).merge(
                caption: false,
                position: :before_body
              ))
          end unless Refinery::Blog::Posts.get_extras(:before, :body)[:imageable_images].present?

          Refinery::Blog::Posts::Tab.register do |tab|
            tab.name = 'imageable'
            tab.partial = '/refinery/admin/imagenization/tabs/images'
          end unless Refinery::Blog::Posts.tabs.collect(&:name).include?('imageable')
        end
      end
    end
  end
end

module Refinery
  module Imageable
    module Page

      class << self
        def patch
          require 'refinery/page' unless defined?(Refinery::Page)

          return unless Refinery::Page.table_exists? rescue return

          patch_model
          patch_controllers
          patch_presenters_views
        end

        private

        def patch_model
          Refinery::Page.send :is_imageable
        end

        def patch_controllers
          Refinery::Admin::PagesController.class_eval do
            private

            def permitted_page_params_with_imagenization
              @permitted_page_params ||= permitted_page_params_without_imagenization +
                          [imagenizations_attributes: [:id, :image_id, :featured, :position, image_attributes: [:id, :alt, :caption]]]
            end

            alias_method_chain :permitted_page_params, :imagenization
          end

          Refinery::PagesPreviewController.class_eval do
            private

            def permitted_page_params_with_imagenization
              @permitted_page_params ||= permitted_page_params_without_imagenization +
                          [imagenizations_attributes: [:id, :image_id, :featured, :position, image_attributes: [:id, :alt, :caption]]]
            end

            alias_method_chain :permitted_page_params, :imagenization
          end
        end

        def patch_presenters_views
          options = Refinery::Imageable.imageables_image_options[:page] || {}

          Refinery::Pages.add_section_extra :before, :body, :imageable_images do |page|
            Refinery::ImageableImagesPresenter.new(page, (options[:before_body] || {}).merge(
                position: :before_body
              ))
          end unless Refinery::Pages.get_extras(:before, :body)[:imageable_images].present?

          Refinery::Pages::Tab.register do |tab|
            tab.name = 'imageable'
            tab.partial = '/refinery/admin/imagenization/tabs/images'
          end unless Refinery::Pages.tabs.collect(&:name).include?('imageable')
        end
      end
    end
  end
end

module Refinery
  module Imageable
    module Page

      class << self
        def patch
          require 'refinery/page' unless defined?(Refinery::Page)

          return unless Refinery::Page.table_exists? rescue return

          patch_model
          patch_controllers
          register_pages_tab
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

        def register_pages_tab
          Refinery::Pages::Tab.register do |tab|
            tab.name = 'imageable'
            tab.partial = '/refinery/admin/imagenization/tabs/images'
          end unless Refinery::Pages.tabs.collect(&:name).include?('imageable')
        end
      end
    end
  end
end
